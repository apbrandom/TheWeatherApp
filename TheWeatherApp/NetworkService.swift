//
//  NetworkService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 14.09.2023.
//
let apiKey = "5ce5fb1b-d47e-432e-8825-b5a2577f089b"

import Foundation

class NetworkService {
    
    internal func createURL() -> URL? {
        let baseURL = "https://api.weather.yandex.ru/v2/forecast?"
        let latitude = "55.7558"
        let longitude = "37.6176"
        let language = "ru_RU"
        let limit = "7"
        
        let urlStringWithParam = "\(baseURL)lat=\(latitude)&lon=\(longitude)&lang=\(language)&limit=\(limit)"
        let url = URL(string: urlStringWithParam)
        return url
    }
    
    func fetchNetworkModel() async throws -> WeatherNetworkModel {
        guard let url = createURL() else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(WeatherNetworkModel.self, from: data)
                print("NetworkService: getting data from URL and decoding to WeatherNetworkModel successfully")
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




//    func fetchWeather(cityName: String) {
//        let urlString = "\(weatherURL)&q=\(cityName)"
//        performRequest(with: urlString)
//    }
//
//    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "\(weatherURL)%lat=\(latitude)%lon=\(longitude)"
//        performRequest(with: urlString)
//    }
