//
//  GetStartedView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI
import Combine

struct GetStartedView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: GetStartedViewModel
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    if colorScheme == .light {
                        backgroundGradientLight
                    } else {
                        backgroundGradientDark
                    }
                }.ignoresSafeArea()
                
                
                VStack(spacing: 10) {
                    Text("GetStartedView_Armadio".localized)
                        .textStyle(TitleStyle())
                    Spacer()
                    Image("default")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Text("GetStartedView_Welcome".localized)
                        .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                    Text("GetStartedView_Enjoy".localized)
                        .textStyle(NormalStyle())
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button("GetStartedView_Get".localized) {
                        viewModel.showingSheet.toggle()
                    }
                    .sheet(isPresented: $viewModel.showingSheet) {
                        LoginOptionsView(viewModel: LoginOptionsViewModel())
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                    .buttonStyle(RoundedButtonStyle(foregroundColor: .white, backgroundColor: .purple))
                }
                .padding()
            }
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
        }
    }
    
    //MARK: - LinearGradient Background
    
    private let backgroundGradientLight = LinearGradient(
        colors: [Color.purple, Color.red],
        startPoint: .top, endPoint: .bottom
    )
    
    private let backgroundGradientDark = LinearGradient(
        colors: [Color.purple, Color.black],
        startPoint: .top, endPoint: .bottom
    )
}

//MARK: - Preview

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView(viewModel: GetStartedViewModel())
    }
}
