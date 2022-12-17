//
//  ColorPickerDetails.swift
//  Armadio
//
//  Created by Bartłomiej on 01/11/2022.
//

import SwiftUI

/// Details of selected ``Clothe`` in ``AddNewClotheView``.
struct ColorPickerDetails: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selection: Color
    private let title: String = "Color"
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown, .white, .gray, .black]
    
    let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(colors, id: \.self) { color in
                        ZStack {
                            Circle()
                                .fill(color)
                                .frame(width: 50, height: 50)
                                .onTapGesture(perform: {
                                    selection = color
                                    dismiss()
                                })
                                .padding(10)
                            
                            if selection == color {
                                Circle()
                                    .stroke(color, lineWidth: 5)
                                    .frame(width: 60, height: 60)
                            }
                        }
                    }
                }
                .background(.gray.opacity(0.2))
                Spacer()
            }
            .padding(10)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationButton(type: .back) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ColorPickerDetails_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerDetails(selection: .constant(.red))
    }
}
