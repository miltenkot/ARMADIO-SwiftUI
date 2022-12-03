//
//  PrimaryButton.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    let foregroundColor: Color
    let backgroundColor: Color
    let imageName: String?
    let action: () -> Void
    
    init(text: String,
         foregroundColor: Color = .themeColor(.primaryButtonFColor),
         backgroundColor: Color = .themeColor(.primaryButtonBColor),
         imageName: String? = nil, action: @escaping () -> Void) {
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

struct PrimaryAsyncButton: View {
    let text: String
    let foregroundColor: Color
    let backgroundColor: Color
    let imageName: String?
    let action: () async -> Void
    
    init(text: String,
         foregroundColor: Color = .themeColor(.primaryButtonFColor),
         backgroundColor: Color = .themeColor(.primaryButtonBColor),
         imageName: String? = nil, action: @escaping () -> Void) {
        self.text = text
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.imageName = imageName
        self.action = action
    }
    
    var body: some View {
        AsyncButton {
            await action()
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

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrimaryButton(text: "Default", foregroundColor: .white, backgroundColor: .blue, imageName: "applelogo", action: {})
            PrimaryButton(text: "Default", foregroundColor: .white, backgroundColor: .blue, action: {})
        }
    }
}

struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @State private var isPerformingTask = false

    var body: some View {
        Button(
            action: {
                isPerformingTask = true
            
                Task {
                    await action()
                    isPerformingTask = false
                }
            },
            label: {
                ZStack {
                    label().opacity(isPerformingTask ? 0 : 1)

                    if isPerformingTask {
                        ProgressView()
                    }
                }
            }
        )
        .disabled(isPerformingTask)
    }
}
