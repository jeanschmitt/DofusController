//
//  Menu.swift
//  DofusController
//
//  Created by Jean Schmitt on 13/03/2022.
//

import SwiftUI

struct MenuView: View {
    var activateAction: ((Bool) -> Bool)?
    var invertAction: ((Bool) -> Bool)?
    
    var body: some View {
        VStack {
            VStack {
                Text("Dofus Companion")
                Spacer()
                CustomToggle(label: "Activer", action: activateAction ?? noOp)
                CustomToggle(label: "Inverser", action: invertAction ?? noOp)
            }
            .padding(10)
            Spacer()
            MenuButton(title: "Quitter") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding(5)
    }
    
    private func noOp(isOn: Bool) -> Bool {
        return isOn
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .frame(width: 200.0, height: 150.0)
    }
}

struct MenuButton: View {
    var title: String
    var action: () -> Void
    @State private var isHoverred = false
    
    var body: some View{
        Button(action: action) {
            Text(title)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(5)
        .background(isHoverred ? Color.secondary.opacity(0.2) : .clear)
        .cornerRadius(4)
        .onHover { hoverred in
            isHoverred = hoverred
        }
    }
}
