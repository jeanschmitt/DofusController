//
//  AppDelegate.swift
//  DofusController
//
//  Created by Jean Schmitt on 13/03/2022.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popOver: NSPopover!
    private var listener: Listener!

    func applicationDidFinishLaunching(_ notification: Notification) {
        initStatusItem()
        initPopOver()
    }

    func initStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        if let button = statusItem?.button {
            button.image = NSImage(named: "MenuBarIcon")
            button.action = #selector(togglePopOver)
        }
    }
    
    func initPopOver() {
        let contentView = MenuView(activateAction: activateAction, invertAction: invertAction)
        
        popOver = NSPopover()
        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSHostingController(rootView: contentView)
        popOver.contentViewController?.preferredContentSize = NSSize(width: 200, height: 150)
    }
    
    @objc func togglePopOver(_ sender: AnyObject?) {
        if let button = statusItem?.button {
            if popOver.isShown {
                popOver.performClose(sender)
            } else {
                popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                popOver.contentViewController?.view.window?.becomeKey()
            }
        }
    }
    
    private func activateAction(isOn: Bool) -> Bool {
        if isOn {
            do {
                try Listener.shared.enable()
            } catch {
                print("couldn't activate")
                return false
            }
        } else {
            Listener.shared.disable()
        }
        return isOn
    }
    
    private func invertAction(isOn: Bool) -> Bool {
        Accounts.shared.inverseOrder = isOn
        return isOn
    }
}
