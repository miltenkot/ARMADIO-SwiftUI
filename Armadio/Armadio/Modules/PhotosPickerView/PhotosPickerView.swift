//
//  PhotosPickerView.swift
//  Armadio
//
//  Created by Bartłomiej on 14/11/2022.
//

import SwiftUI
import PhotosUI

struct PhotosPickerView: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                if let selectedImageData = selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    CircleImage(image: Image(uiImage: uiImage))
                } else {
                    CircleImage(image:(Image(systemName: "photo.circle.fill")))
                }
            }.onChange(of: selectedItem, perform: { newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            })
    }
}

struct PhotosPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerView(selectedItem: .constant(.init(itemIdentifier: "empty")),
                         selectedImageData: .constant(nil))
    }
}
