//
//  SelectYourCountryViewModelTests.swift
//  ArmadioUnitTests
//
//  Created by Bartlomiej Lanczyk on 31/10/2022.
//

import XCTest
import Factory
@testable import Armadio

final class SelectYourCountryViewModelTests: XCTestCase {
    
    var sut: SelectYourCountryViewModel!

    override func setUp() {
        super.setUp()
        Container.Registrations.push()
        Container.setupMocks()
        sut = SelectYourCountryViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        Container.Registrations.pop()
    }
    
    func testGetSelectedCountryName() {
        XCTAssertEqual(sut.getCountryName(), "Austria")
    }
    
    func testGetSelectedCountryFlag() {
        XCTAssertEqual(sut.getCountryFlag(), "🇦🇹")
    }

}
