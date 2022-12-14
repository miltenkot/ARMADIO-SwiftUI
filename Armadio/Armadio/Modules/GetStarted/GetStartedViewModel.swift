//
//  GetStartedViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

enum SplashState: Double {
    case begin = 0, end = 1
}

enum OpacityState: Double {
    case fullyTransparent = 0, fullyOpaque = 1
}

final class GetStartedViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var splashState: SplashState = .begin
    @Published var opacity: OpacityState = .fullyTransparent
}
