//
//  NavigationPickerDetailsDate.swift
//  Armadio
//
//  Created by Bartłomiej on 06/11/2022.
//

import SwiftUI

/// Details of Date picker.
struct NavigationPickerDetailsDate: View {
    @Environment(\.dismiss) var dismiss
    @State private var isDisplayed: Bool = false
    @State private var effectAppear = false
    @State private var selectedDate: Date = .now
    private let title: String = "Date Of Purchase"
    @Binding var bindingItem: Date
    
    init(date: Binding<Date>) {
        self._bindingItem = date
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Date Of Purchase")
                                .font(.system(size: 12, weight: .light))
                            Text(selectedDate.formatted(.dateTime.day().month().year()))
                        }
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(Color.themeColor(.primaryText))
                    .padding()
                    .frame(height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(effectAppear ? .blue : .gray,
                                    lineWidth: 2)
                    )
                    .onTapGesture {
                        isDisplayed.toggle()
                    }
                    .sheet(isPresented: $isDisplayed) {
                        DatePicker(
                                    "Pick a date",
                                    selection: $selectedDate,
                                    in: ...Date(),
                                    displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                        .presentationDetents([.medium])
                    }
                }.padding()
                Spacer()
                PrimaryButton(text: "Save") {
                    bindingItem = selectedDate
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
            selectedDate = bindingItem
        }
    }
}

struct NavigationPickerDetailsDate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPickerDetailsDate(date: .constant(.now))
    }
}
