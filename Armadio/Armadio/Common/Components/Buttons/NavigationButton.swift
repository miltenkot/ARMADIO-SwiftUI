//
//  DismissButton.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

/// Types used in ``NavigationButton`` to represent actions.
enum NavigationButtonType {
    case close
    case back
    case add
    case delete
    case refresh
}

/// Primary navigation button.
struct NavigationButton: View {
    @Environment(\.colorScheme) var colorScheme
    let type: NavigationButtonType
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: getImageName())
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundColor(colorScheme == .dark ? Color(UIColor.darkGray): Color((UIColor.lightGray)))
                .background(colorScheme == .dark ? .white : .black)
                .cornerRadius(30)
        }
    }
    
    private func getImageName() -> String {
        switch type {
        case .delete:
            return "trash.circle.fill"
        case .close:
            return "multiply.circle.fill"
        case .back:
            return "arrow.backward.circle.fill"
        case .add:
            return "plus.circle.fill"
        case .refresh:
            return "arrow.clockwise.circle.fill"
        }
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(type: .delete, action: {})
        NavigationButton(type: .close, action: {})
        NavigationButton(type: .back, action: {})
        NavigationButton(type: .add, action: {})
        NavigationButton(type: .refresh, action: {})
    }
}
