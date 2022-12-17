//
//  Optional+Extension.swift
//  ArmadioUnitTests
//
//  Created by Bartłomiej on 21/11/2022.
//

import Foundation

/// Provide  RawRepresentable conformance to our custom Codable type `Optional`, becasue AppStorage only supports RawRepresentable where the RawValue's associatedtype is of type Int or String.
extension Optional: RawRepresentable where Wrapped: Codable {
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let json = String(data: data, encoding: .utf8)
        else {
            return "{}"
        }
        return json
    }

    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let value = try? JSONDecoder().decode(Self.self, from: data)
        else {
            return nil
        }
        self = value
    }
}
