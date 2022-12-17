//
//  ButtonMenuItem.swift
//  Armadio
//
//  Created by Bartłomiej on 01/11/2022.
//

import SwiftUI

/// Circle button use to create ``FloatingButton``.
struct ButtonMenuItem: View {
    let action: () -> Void
    var icon: String
    var name: String
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(name)
                    .font(.system(size: 19, weight: .semibold))
                    .padding(5)
                    .foregroundColor(Color.themeColor(.primaryButtonFColor))
                    .background(Color.themeColor(.primaryColor))
                ZStack {
                    Circle()
                        .foregroundColor(Color.themeColor(.primaryColor))
                        .frame(width: 55, height: 55)
                    Image(systemName: icon)
                        .imageScale(.large)
                        .foregroundColor(Color.themeColor(.primaryButtonFColor))
                }
                
            }
        }
    }
}

struct ButtonMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMenuItem(action: {}, icon: "plus.circle.fill", name: "Add new")
    }
}
