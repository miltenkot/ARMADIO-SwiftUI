//
//  ContinueButton.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

struct ContinueButton: View {
    let text: String
    let foregroundColor: Color
    let backgroundColor: Color
    let imageName: String?
    let action: () -> Void
    
    init(text: String, foregroundColor: Color, backgroundColor: Color, imageName: String? = nil, action: @escaping () -> Void) {
        self.text = text
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.imageName = imageName
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if let imageName {
                    Image(systemName: imageName)
                }
                Text(text)
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(RoundedButtonStyle(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
}

struct ContinueButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContinueButton(text: "Default", foregroundColor: .white, backgroundColor: .blue, imageName: "applelogo", action: {})
            ContinueButton(text: "Default", foregroundColor: .white, backgroundColor: .blue, action: {})
        }
        
    }
}
