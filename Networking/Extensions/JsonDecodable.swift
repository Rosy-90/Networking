//
//  JSONDecodable.swift
//  Networking
//
//  Created by Rosy Patel on 14/06/2022.
//

import Foundation

protocol JsonDecodable {
    func decode<T: Decodable>(input: Data, type: T.Type) -> [T]?
}

extension JsonDecodable {
    func decode<T: Decodable>(input: Data, type: T.Type) -> [T]? {
        return try? JSONDecoder().decode([T].self, from: input)
    }
}
