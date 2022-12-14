//
//  ReceiptDetails.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import SwiftUI
import UIKit

struct ReceiptDetails: View {
    @Environment(\.dismiss) var dismiss
    let imageData: Data?
    
    var body: some View {
        NavigationView {
            Group {
                if let data = imageData {
                    Image(uiImage: UIImage(data: data)!)
                        .resizable()
                        .scaledToFit()
                        .padding()
                } else {
                    Text("ReceiptDetails_NoContent".localized)
                        .textStyle(TitleStyle())
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationButton(type: .close) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ReceiptDetails_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptDetails(imageData: nil)
    }
}
