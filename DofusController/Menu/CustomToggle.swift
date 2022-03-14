//
//  CustomToggle.swift
//  DofusController
//
//  Created by Jean Schmitt on 14/03/2022.
//

import SwiftUI

struct CustomToggle: View {
    var label: String
    var action: (Bool) -> Bool
    
    @State private var isOn = false
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Toggle(label, isOn: $isOn)
                .toggleStyle(.switch)
                .labelsHidden()
                .onChange(of: isOn) { _isOn in
                    isOn = action(_isOn)
                }
        }
    }
}

struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
        CustomToggle(label: "Activate") { _isOn in
            return _isOn
        }
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
