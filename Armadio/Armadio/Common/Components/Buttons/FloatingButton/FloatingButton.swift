//
//  FloatingButton.swift
//  Armadio
//
//  Created by Bartłomiej on 01/11/2022.
//

import SwiftUI

struct FloatingButton: View {
    @Binding var showMenuItems: Bool
    
    let addNewAction: () -> Void
    let statsAction: () -> Void
    let listAction: () -> Void

    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            if showMenuItems {
                ButtonMenuItem(action: addNewAction, icon: "plus.circle.fill", name: "Add new")
                ButtonMenuItem(action: statsAction, icon: "photo.on.rectangle", name: "Stats")
                ButtonMenuItem(action: listAction, icon: "list.bullet.circle.fill", name: "List")
            }
            Button(action: {
                self.showMenu()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color.themeColor(.primaryColor))
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
                       addNewAction: {},
                       statsAction: {},
                       listAction: {})
    }
}
