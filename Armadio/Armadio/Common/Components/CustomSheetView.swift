//
//  CustomSheetView.swift
//  Armadio
//
//  Created by Bartłomiej on 22/11/2022.
//

import SwiftUI
import CoreData

/// Sheet to get preview of selected current ``Clothe`` in ``NowView``.
struct CustomSheetView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    @Binding var selectedClothe: LocalClothe?
    
    var body: some View {
        //Here we have not any clothe on slot
        if selectedClothe == nil {
            SelectYourClotheView(selectedClothe: $selectedClothe)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            //Here we have clothe added
        } else {
            if let clothe = getItem(with: selectedClothe?.id){
                NowToolbar(clothe: clothe) {
                    selectedClothe = nil
                    dismiss()
                } addAgain: {
                    selectedClothe = nil
                } dismissAction: {
                    dismiss()
                }
            }
        }
    }
    
    private func getItem(with id: UUID?) -> Clothe? {
        guard let id = id else { return nil }
        let request = Clothe.fetchRequest() as NSFetchRequest<Clothe>
        request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        guard let items = try? context.fetch(request) else { return nil }
        return items.first
    }
}

struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSheetView(selectedClothe: .constant(nil))
    }
}
