//
//  NetworkingService.swift
//  Weather
//
//  Created by Josh Franco on 9/17/23.
//

import Foundation

class NetworkingService {
    static var shared = NetworkingService()

    // TODO: Update me to be injectable
    private init() {}
    
    
    
    func start() {
        
        let url = URL(string: "https://samples.openweathermap.org/data/2.5/history/city?id=2885679&type=hour&appid=\(Constants.openWeatherAPIKey)")!
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }

            guard let data = data else {
                return
            }

            guard let dictionaryObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return
            }

            guard let list = dictionaryObj["list"] as? [[String: Any]] else {

                return
            }

            if let first = list.first, let wind = first["wind"] {
                print(wind)
            }
        }).resume()
        
    }
}
