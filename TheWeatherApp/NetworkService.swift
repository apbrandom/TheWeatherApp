//
//  NetworkService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 14.09.2023.
//
let coordinate = "lat=55.7558&lon=37.6176"
let apiKey = "5ce5fb1b-d47e-432e-8825-b5a2577f089b"

import Foundation

enum NetworkError: Error {
    case badURL, badRequest, badResponse, invalidData, invalidDecoding
}

final class NetworkService {
    internal func createURL(lat: String, lon: String) -> URL? {
        let baseURL = "https://api.weather.yandex.ru/v2/forecast?"
        let latitude = lat
        let longitude = lon
        let language = "ru_RU"
        let limit = "7"
        let hours = "true"
        
        let urlStringWithParam = "\(baseURL)lat=\(latitude)&lon=\(longitude)&lang=\(language)&limit=\(limit)&hours=\(hours)"
        let url = URL(string: urlStringWithParam)
        return url
    }
    
    func fetchNetworkModel(lat: String, lon: String) async throws -> WeatherNetworkModel {
        guard let url = createURL(lat: lat, lon: lon) else {
            throw NetworkError.badURL
        }
        print("----------\(url)")
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(WeatherNetworkModel.self, from: data)
                print("--NetworkService: getting data from URL and decoding")
                
                return result
            } catch let decodingError {
                print("Decoding failed: \(decodingError)")
                throw decodingError
            }
            

        } catch let requestError {
            print("Request failed: \(requestError)")
            throw requestError
        }
    }
}


