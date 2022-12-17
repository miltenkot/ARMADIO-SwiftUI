//
//  NavigationPickerLabel.swift
//  Armadio
//
//  Created by Bartłomiej on 07/11/2022.
//

import SwiftUI

/// Label used in ``AddNewClotheView`` and ``AccountList`` to repesent list element preview.
struct NavigationPickerLabel<ContentView: View>: View {
    let title: String
    var content: ContentView
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            content
                .lineLimit(1)
                .bold()
        }
        .foregroundColor(Color.themeColor(.primaryText))
        .padding()
    }
}

struct NavigationPickerLabel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPickerLabel(title: "Default",
                                     content: Text("Bold"))
    }
}
