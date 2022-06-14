//
//  HTTPError.swift
//  Networking
//
//  Created by Rosy Patel on 14/06/2022.
//

import Foundation

enum HTTPError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}
