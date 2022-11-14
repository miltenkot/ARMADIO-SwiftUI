//
//  CustomOverlayedButton.swift
//  Armadio
//
//  Created by Bartłomiej on 22/11/2022.
//

import SwiftUI

struct CustomOverlayedButton<CustomButton: View>: View {
    @Binding var selectedClothe: LocalClothe?
    var customButton: CustomButton
    
    var body: some View {
        customButton
            .overlay(Circle().stroke(selectedClothe == nil ? .clear : .green, lineWidth: 4))
    }
}

struct CustomOverlayedButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomOverlayedButton(selectedClothe: .constant(nil), customButton: NavigationButton(type: .add, action: {
            
        }))
    }
}
