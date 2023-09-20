//
//  NetworkServiceable.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Combine

protocol NetworkServiceable {
    func request<T: Decodable>(_ endpoint: Endpoint,
                               headers: [String: String]?,
                               queryParameters: [String: String]?,
                               body: Encodable?) -> AnyPublisher<T, APIError>
}
