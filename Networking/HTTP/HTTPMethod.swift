//
//  HTTPMethod.swift
//  Networking
//
//  Created by Rosy Patel on 14/06/2022.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    public let rawValue: String
    
    public init?(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
}
