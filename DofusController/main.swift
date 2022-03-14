//
//  main.swift
//  DofusController
//
//  Created by Jean Schmitt on 13/03/2022.
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
