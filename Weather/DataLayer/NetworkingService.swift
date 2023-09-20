//
//  NetworkingService.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation
import Combine

class NetworkingService {
    private let baseURL: String
    // TODO: Update me with relevant default headers
    private var defaultHeaders: [String: String] {
        var headers = ["Platform": "iOS",
                       "User-Token": "your_user_token",
                       "uid": "user-id"]
        
        if let appVersion = Constants.appVersion {
            headers["App-Version"] = appVersion
        }
        
        return headers
    }
    
    init(environment: APIEnvironment = Constants.currentEnvironment) {
        self.baseURL = environment.baseURL
    }
}

// TODO: - Comment all the networking code
extension NetworkingService: NetworkServiceable {
    func request<T>(_ endpoint: Endpoint,
                    headers: [String : String]?,
                    queryParameters: [String: String]?,
                    body: Encodable?) -> AnyPublisher<T, APIError> where T : Decodable {
        guard var url = URL(string: baseURL + endpoint.path) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        if let parameters = queryParameters {
            let query = parameters.map({ URLQueryItem(name: $0, value: $1) })
            url.append(queryItems: query)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        let allHeaders = self.defaultHeaders.merging(headers ?? [:],
                                                     uniquingKeysWith: { $1 })
        allHeaders.forEach({ urlRequest.setValue($0, forHTTPHeaderField: $1) })
        
        if let body = body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let jsonData = try JSONEncoder().encode(body)
                urlRequest.httpBody = jsonData
            } catch {
                return Fail(error: APIError.requestFailed("Parameter Encoding parameters failed.")).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                guard   // Check the status code to ensure its in range, if not the request fails
                    let httpResponse = response as? HTTPURLResponse,
                    (200..<300).contains(httpResponse.statusCode)
                else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    throw APIError.requestFailed("Request failed with status code: \(statusCode)")
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    print("zzz json: \(json)")
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if error is DecodingError {
                    return APIError.decodingFailed(error)
                } else if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.requestFailed("An unknown error occurred.")
                }
            }
            .eraseToAnyPublisher()
    }
}
