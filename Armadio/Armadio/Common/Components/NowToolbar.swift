//
//  NowToolbar.swift
//  Armadio
//
//  Created by Bartłomiej on 21/11/2022.
//

import SwiftUI

struct NowToolbar: View {
    let clothe: Clothe
    let deleteAction: () -> Void
    let addAgain: () -> Void
    let dismissAction: () -> Void
    var body: some View {
        NavigationView {
            ClotheDetails(clothe: clothe)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationButton(type: .delete) {
                            deleteAction()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationButton(type: .refresh) {
                            addAgain()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationButton(type: .close) {
                            dismissAction()
                        }
                    }
                }
        }
    }
}

struct NowToolbar_Previews: PreviewProvider {
    static var previews: some View {
        NowToolbar(clothe: Clothe.mock, deleteAction: {
            
        }, addAgain: {
            
        }, dismissAction: {
            
        })
    }
}
