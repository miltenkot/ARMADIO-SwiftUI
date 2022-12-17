//
//  AccountRow.swift
//  Armadio
//
//  Created by Bartłomiej on 03/12/2022.
//

import SwiftUI
import UIKit

/// View showing ``UserInfo`` logo, name and login provider using ``AuthenticationViewModel``.
struct AccountRow: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        HStack {
            if let imageURL = authViewModel.currentUserInfo()?.photo {
                AsyncImage(url: imageURL)
                    .frame(width: Constants.widthSmall, height: Constants.heightSmall)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .padding(.trailing)
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.blue)
                    .frame(width: Constants.widthSmall, height: Constants.heightSmall)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .padding(.trailing)
            }
            
            VStack(alignment: .leading) {
                Text("\(authViewModel.currentUserInfo()?.displayName ?? "Empty")")
                    .font(.custom("AvenirNext-Bold", size: Constants.fontMedium))
                Text("\(authViewModel.currentUserInfo()?.uid ?? "Empty")")
                    .font(.custom("AvenirNext-Demibold", size: Constants.fontSmall))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct MyProfileRow_Previews: PreviewProvider {
    static let authViewModel = AuthenticationViewModel()
    static var previews: some View {
        AccountRow()
            .environmentObject(authViewModel)
    }
}
