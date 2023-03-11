//
//  UserFormTextField.swift
//  Armadio
//
//  Created by Bartłomiej on 01/12/2022.
//

import SwiftUI

/// Enum of ``UserFormTextField`` type.
enum UserFormType {
    case email, firstName, lastName, password, repeatPassword
    
    var title: String {
        switch self {
        case .email:
            return "Email"
        case .firstName:
            return "First name"
        case .lastName:
            return "Last Name"
        case .password:
            return "Password"
        case .repeatPassword:
            return "Repeat Password"
        }
    }
}

/// TextField which user fill during authentication of ``UserFormType``.
struct UserFormTextField: View {
    @State private var effectAppear = false
    @FocusState private var fieldFocused: Bool
    @Binding var text: String
    var type: UserFormType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Group {
                    if type == .password || type == .repeatPassword {
                        SecureField("\(type.title)", text: $text) 
                    } else {
                        TextField("\(type.title)", text: $text) { onChange in
                            if onChange {
                                effectAppear = true
                            } else {
                                effectAppear = false
                            }
                        }
                    }
                }
                .focused($fieldFocused)
                .font(.body)
                .disableAutocorrection(true)
            }
            Spacer()
            if effectAppear {
                Button {
                    text = ""
                    effectAppear = false
                    fieldFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                }
            }
        }
        .foregroundColor(Color.themeColor(.primaryText))
        .padding()
        .frame(maxHeight: 60)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(effectAppear ? .blue : .gray,
                        lineWidth: 2)
        )
    }
}

struct UserFormTextField_Previews: PreviewProvider {
    static var previews: some View {
        UserFormTextField(text: .constant("@gmail.com"), type: .email)
            .previewLayout(.sizeThatFits)
    }
}
