//
//  Listener.swift
//  DofusController
//
//  Created by Jean Schmitt on 13/03/2022.
//

import Cocoa

class Listener {
    public static let shared = Listener()
    
    private var eventTap: CFMachPort?
    
    static private let eventMask = CGEventMask(1 << CGEventType.otherMouseDown.rawValue)
    
    private init() { }
    
    func checkTrust() -> Bool {
        let promptKey = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
        let opts = [promptKey: true] as CFDictionary
        return AXIsProcessTrustedWithOptions(opts)
    }
    
    func enable() throws {
        if eventTap == nil {
            try initTap()
        }
        
        CGEvent.tapEnable(tap: eventTap!, enable: true)
    }
    
    func disable() {
        if let tap = eventTap {
            CGEvent.tapEnable(tap: tap, enable: false)
        }
    }
    
    private func initTap() throws {
        guard let tap = CGEvent.tapCreate(tap: .cgSessionEventTap, place: .headInsertEventTap, options: .listenOnly, eventsOfInterest: Listener.eventMask, callback: eventCallback, userInfo: nil) else {
            throw EventListenerError.cantCreateTap
        }
        eventTap = tap
                

        RunLoop.main.add(eventTap!, forMode: .common)
    }
    
    private let eventCallback: CGEventTapCallBack = { (proxy, type, event, _) in
        if type == .otherMouseDown {
            switch event.getIntegerValueField(.mouseEventButtonNumber) {
            case 3:
                Accounts.shared.previous()
            case 4:
                Accounts.shared.next()
            default:
                break
            }
        }

        return Unmanaged.passRetained(event)
    }
}

enum EventListenerError: Error {
    case cantCreateTap
}
