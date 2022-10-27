//
//  LoginOptionsViewTests.swift
//  ArmadioUnitTests
//
//  Created by Bartłomiej on 27/10/2022.
//

import XCTest
import ViewInspector
@testable import Armadio

extension LoginOptionsView: Inspectable {}
extension ContinueButton: Inspectable {}

final class LoginOptionsViewTests: XCTestCase {

    func test_ContinueButtons_Titles() throws {
        let view = LoginOptionsView(viewModel: LoginOptionsViewModel())
        XCTAssertNoThrow(try view.inspect().find(ContinueButton.self, containing: "Continue with Apple"))
        XCTAssertNoThrow(try view.inspect().find(ContinueButton.self, containing: "Continue with Facebook"))
        XCTAssertNoThrow(try view.inspect().find(ContinueButton.self, containing: "Continue with Google"))
        XCTAssertNoThrow(try view.inspect().find(ContinueButton.self, containing: "Continue with email"))
        XCTAssertNoThrow(try view.inspect().find(ContinueButton.self, containing: "Continue with guest"))
    }

}
