//
//  CheckboxView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

struct CheckboxView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let readMoreAction: () -> Void
    @Binding var checkState: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Button {
                checkState.toggle()
            } label: {
                HStack {
                    Rectangle()
                        .frame(width: 30, height:30, alignment: .center)
                        .overlay {
                            Image(systemName: (checkState == true) ? "checkmark.square.fill" : "square.fill")
                                .resizable()
                                .foregroundColor((checkState == true) ? .blue : checkboxColor)
                                .background(checkboxColor)
                            
                        }
                        .border(.blue, width: 3)
                        .cornerRadius(5)
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("CheckboxView_Statement".localized)
                    .multilineTextAlignment(.leading)
                Button("CheckboxView_Read".localized) {
                    readMoreAction()
                }
                .foregroundColor(.blue)
            }
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(Color.themeColor(.primaryText))
        }
        .foregroundColor(Color.white)
    }
    
    private var checkboxColor: Color {
        switch colorScheme {
        case .dark: return .black
        case .light: return .white
        @unknown default: return .black
        }
    }
}

struct CheckboxView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            CheckboxView(readMoreAction: {
            }, checkState: .constant(false))
            
            CheckboxView(readMoreAction: {
            }, checkState: .constant(true))
        }.preferredColorScheme(.dark)
        Group {
            CheckboxView(readMoreAction: {
            }, checkState: .constant(false))
            
            CheckboxView(readMoreAction: {
            }, checkState: .constant(true))
        }.preferredColorScheme(.light)
    }
}
