//
//  GetStartedView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI
import Combine

struct GetStartedView: View {
    @Namespace var ns
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = GetStartedViewModel()
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    
                    if viewModel.splashState == .begin {
                        logoImage()
                            .resizable()
                            .scaledToFit()
                            .matchedGeometryEffect(id: "splashAnimation", in: ns)
                            .padding()
                    }
                    
                    if viewModel.splashState == .end {
                        VStack(spacing: Constants.spacingSmall) {
                            logoImage()
                                .resizable()
                                .scaledToFit()
                                .matchedGeometryEffect(id: "splashAnimation", in: ns)
                                .padding(.top, Constants.paddingTopMedium)
                                .padding(.horizontal, Constants.paddingHorizontalMedium)
                            Group {
                                Spacer()
                                Image("wardrobe")
                                    .resizable()
                                    .scaledToFit()
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
                                    LoginOptionsView()
                                        .presentationDetents([.large])
                                        .presentationDragIndicator(.visible)
                                }
                                .buttonStyle(RoundedButtonStyle(
                                    foregroundColor: .white,
                                    backgroundColor: Color.themeColor(.primaryColor)
                                ))
                            }
                            .opacity(viewModel.opacity.rawValue)
                        }
                        .padding()
                    }
                }
            }
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeIn(duration: 1.2)) {
                        viewModel.splashState = .end
                    }
                }
            }
            .onAnimationCompleted(for: viewModel.splashState.rawValue) {
                viewModel.opacity = .fullyOpaque
            }
        }
    }
}

extension GetStartedView {
    private func logoImage() -> Image {
        (colorScheme == .dark) ? Image("armadio_white") : Image("armadio_black")
    }
}

//MARK: - Preview

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
