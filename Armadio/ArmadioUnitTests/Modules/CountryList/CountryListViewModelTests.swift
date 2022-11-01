//
//  CountryListViewModelTests.swift
//  ArmadioUnitTests
//
//  Created by Bartlomiej Lanczyk on 31/10/2022.
//

import XCTest
@testable import Armadio

final class CountryListViewModelTests: XCTestCase {

    var sut: CountryListViewModel!

    override func setUp() {
        super.setUp()
        sut = CountryListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetSelectedCountryName() {
        XCTAssertEqual(sut.getCountryName("PL"), "Polska")
    }
    
    func testGetSelectedCountryFlag() {
        XCTAssertEqual(sut.getCountryFlag("PL"), "🇵🇱")
    }

}
