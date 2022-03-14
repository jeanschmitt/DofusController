//
//  Accounts.swift
//  DofusController
//
//  Created by Jean Schmitt on 14/03/2022.
//

import Cocoa

class Accounts {
    public static let shared = Accounts()
    public static var appName = "Dofus"
    
    public var inverseOrder = false
    
    private init() { }
    
    public func next() {
        activateClient(indexDelta: inverseOrder ? -1 : 1)
    }
    
    public func previous() {
        activateClient(indexDelta: inverseOrder ? 1 : -1)
    }
    
    private func activateClient(indexDelta: Int) {
        guard let current = currentClient() else {
            // Skip if Dofus is not front app
            return
        }
        
        let clients = allClients()
        
        if let currentIndex = clients.firstIndex(where: { $0.processIdentifier == current.processIdentifier }) {
            let newIndex = loopIndex(current: currentIndex, delta: indexDelta, size: clients.count)
            clients[newIndex].activate(options: [.activateIgnoringOtherApps])
        }
    }
    
    private func currentClient() -> NSRunningApplication? {
        guard let front = NSWorkspace.shared.frontmostApplication else {
            return nil
        }
        guard front.localizedName == Accounts.appName else {
            return nil
        }
        
        return front
    }
    
    private func allClients() -> [NSRunningApplication] {
        let clients = NSWorkspace.shared.runningApplications.filter { app in
            app.localizedName == Accounts.appName
        }
        
        // Sort by pid, because this is the only field that can be used to sort accounts
        return clients.sorted(by: { $0.processIdentifier < $1.processIdentifier })
    }
}

private func loopIndex(current: Int, delta: Int, size: Int) -> Int {
    return (((current + delta) % size) + size) % size
}
