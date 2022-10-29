//
//  RequiredView.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import SwiftUI

struct RequiredView: View {
    var body: some View {
        HStack {
            Image(systemName: "multiply.circle")
                .foregroundColor(Color.themeColor(.primaryButtonFColor))
                .background(.red)
                .cornerRadius(45)
            Text("Required")
                .textStyle(NormalStyle())
        }
    }
}

struct RequiredView_Previews: PreviewProvider {
    static var previews: some View {
        RequiredView()
    }
}
