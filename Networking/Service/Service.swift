//
//  Service.swift
//  Networking
//
//  Created by Rosy Patel on 14/06/2022.
//

import Foundation

protocol Servicable: JsonDecodable {
    func fetchData<T: Codable>(networkClient: NetworkClient, type: T.Type, completionHandler: @escaping Completion<T>)
}

typealias Completion<T: Decodable> =  ((Result<[T], HTTPError>) -> Void)

public class Service: Servicable {
    public static let shared = Service()

    func fetchData<T: Decodable>(networkClient: NetworkClient,
                                 type: T.Type,
                                 completionHandler: @escaping Completion<T>) {
        let urlSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?

        guard let urlComponents = URLComponents(string: networkClient.baseURL) else {
            completionHandler(.failure(.urlFailed))
            return
        }

        guard let url = urlComponents.url else {
            completionHandler(.failure(.urlFailed))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = networkClient.method
                dataTask = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, _) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.requestError))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }

            if let result = self?.decode(input: data, type: type) {
                completionHandler(.success(result))
            } else {
                completionHandler(.failure(.parsingFailed))
            }
        }
        dataTask?.resume()
    }
}
