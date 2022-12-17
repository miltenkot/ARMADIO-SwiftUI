//
//  ScannerDetailsView.swift
//  Armadio
//
//  Created by Bartłomiej on 13/11/2022.
//

import SwiftUI

/// Details of saved by receipt scanner image.
struct ScannerDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isRecognizing: Bool
    @Binding var receiptImageData: Data?
    
    var body: some View {
        ScannerView { result in
            switch result {
            case .success(let scannedImages):
                isRecognizing = true
                guard let scannedImage = scannedImages.first,
                      let compressedData = scannedImage.jpegData(compressionQuality: 1.0) else { break }
                receiptImageData = compressedData
            case .failure(let error):
                print(error.localizedDescription)
            }
            dismiss()
        } didCancelScanning: {
            dismiss()
        }
    }
}
