//
//  EntitiesTests.swift
//  ArmadioUnitTests
//
//  Created by Bartłomiej on 15/11/2022.
//

import XCTest
import CoreData
@testable import Armadio

final class EntitiesTests: XCTestCase {
    
    let container = CoreDataStack.preview.container
    
    func testPriceEntity() {
        let priceEntity = container.managedObjectModel.entitiesByName["Price"]!
        verifyAttribute(named: "currencyValue", on: priceEntity, hasType: .string)
        verifyAttribute(named: "amount", on: priceEntity, hasType: .double)
    }

    func testSubcategoryEntity() {
        let subcategoryEntity = container.managedObjectModel.entitiesByName["Subcategory"]!
        verifyAttribute(named: "name", on: subcategoryEntity, hasType: .string)
    }

    func verifyAttribute(named name: String, on entity: NSEntityDescription, hasType type: NSAttributeDescription.AttributeType) {
        guard let attribute = entity.attributesByName[name] else {
            XCTFail("\(entity.name!) is missing expected attribute \(name)")
            return
        }
        XCTAssertEqual(type, attribute.type)
    }
}
