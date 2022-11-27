//
//  SimulatorDefaulView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import SwiftUI

struct SimulatorDefaulView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Text("Content is not available in simulator")
                .toolbar {
                    ToolbarItem {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

struct SimulatorDefaulView_Previews: PreviewProvider {
    static var previews: some View {
        SimulatorDefaulView()
    }
}
