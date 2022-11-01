//
//  FloatingButton.swift
//  Armadio
//
//  Created by Bartłomiej on 01/11/2022.
//

import SwiftUI

struct FloatingButton: View {
    @Binding var showMenuItems: Bool
    
    let action1: () -> Void
    let action2: () -> Void
    let action3: () -> Void

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            if showMenuItems {
                ButtonMenuItem(action: action1, icon: "plus.circle.fill", name: "Add new")
                ButtonMenuItem(action: action2, icon: "photo.on.rectangle", name: "Stats")
                ButtonMenuItem(action: action3, icon: "square.and.arrow.up.fill", name: "Outfits")
            }
            Button(action: {
                self.showMenu()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.purple)
            }
        }
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItems.toggle()
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(showMenuItems: .constant(true),
                       action1: {},
                       action2: {},
                       action3: {})
    }
}
