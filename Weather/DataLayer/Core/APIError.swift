//
//  APIError.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case decodingFailed(Error)
}
