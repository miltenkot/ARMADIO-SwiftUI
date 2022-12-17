//
//  NavigationPickerDetailsDescription.swift
//  Armadio
//
//  Created by Bartłomiej on 04/11/2022.
//

import SwiftUI

/// Details of description picker.
struct NavigationPickerDetailsDescription: View {
    @Environment(\.dismiss) var dismiss
    @State private var text: String = ""
    @State private var effectAppear = false
    @Binding var bindingText: String
    let title: String
    
    init(title: String, text: Binding<String>) {
        self.title = title
        self._bindingText = text
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.system(size: 12, weight: .light))
                            TextEditor(text: $text)
                                .font(.body)
                                .disableAutocorrection(true)
                                .onTapGesture {
                                    effectAppear = true
                                }
                        }
                        Spacer()
                        if effectAppear {
                            Button {
                                text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                            }
                        }
                        
                    }
                }
                .foregroundColor(Color.themeColor(.primaryText))
                .padding()
                .frame(maxHeight: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(effectAppear ? .blue : .gray,
                                lineWidth: 2)
                )
                .padding()
                
                Spacer()
                
                PrimaryButton(text: "Save") {
                    bindingText = text
                    dismiss()
                }
            }
            
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationButton(type: .back) {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            text = bindingText
        }
    }
}

struct NavigationPickerDetailsDescription_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPickerDetailsDescription(title: "Description", text: .constant("default text dsadas sadasd asdad asdadasd asdad asdada adasd asdadsdsda adssada sdasa"))
    }
}
