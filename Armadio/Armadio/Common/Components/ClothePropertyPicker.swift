//
//  ClothePropertyPicker.swift
//  Armadio
//
//  Created by Bartłomiej on 30/11/2022.
//

import SwiftUI
import CoreData

enum ClotheProperty {
    case mostPopular
    case leastPopular
    case mostExpensive
    case leastExpensive
    case eldest
    case newest
    
    var sortDescriptor: [SortDescriptor<Clothe>] {
        switch self {
        case .mostPopular:
            return [SortDescriptor(\Clothe.stats?.numberOfWorn, order: .reverse)]
        case .leastPopular:
            return [SortDescriptor(\Clothe.stats?.numberOfWorn, order: .forward)]
        case .mostExpensive:
            return [SortDescriptor(\Clothe.price?.amount, order: .reverse)]
        case .leastExpensive:
            return [SortDescriptor(\Clothe.price?.amount, order: .forward)]
        case .eldest:
            return [SortDescriptor(\Clothe.dateOfPurchase, order: .forward)]
        case .newest:
            return [SortDescriptor(\Clothe.dateOfPurchase, order: .reverse)]
        }
    }
}

struct ClothePropertyPicker: View {
    @Namespace private var ns
    @Binding var value: ClotheProperty
    
    var body: some View {
        picker
    }
    
    var picker: some View {
        Picker("Time Range", selection: $value.animation(.easeInOut)) {
            Text("↑ Popular").tag(ClotheProperty.mostPopular)
            Text("↓ Popular").tag(ClotheProperty.leastPopular)
            Text("↑ Expensive").tag(ClotheProperty.mostExpensive)
            Text("↓ Expensive").tag(ClotheProperty.leastExpensive)
            Text("Eldest").tag(ClotheProperty.eldest)
            Text("Newest").tag(ClotheProperty.newest)
        }
        .pickerStyle(.segmented)
    }
    
}

struct ClothePropertyPicker_Previews: PreviewProvider {
    static var previews: some View {
        ClothePropertyPicker(value: .constant(.eldest))
    }
}
