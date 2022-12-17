//
//  GetStartedViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

/// Splash screen stats.
enum SplashState: Double {
    case begin = 0, end = 1
}

/// Opactiy `fullyTransparent` and `fullyOpaque` states.
enum OpacityState: Double {
    case fullyTransparent = 0, fullyOpaque = 1
}

/// Provide splash screen animation with button to get started.
final class GetStartedViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var splashState: SplashState = .begin
    @Published var opacity: OpacityState = .fullyTransparent
}
