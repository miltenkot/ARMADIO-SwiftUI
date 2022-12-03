//
//  AccountRow.swift
//  Armadio
//
//  Created by Bartłomiej on 03/12/2022.
//

import SwiftUI

struct AccountRow: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(.blue)
                .frame(width: 80, height: 80)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text("Bartlomiej Lanczyk")
                    .font(.custom("AvenirNext-Bold", size: 20))
                Text("Nothing")
                    .font(.custom("AvenirNext-Demibold", size: 15))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct MyProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountRow()
    }
}
