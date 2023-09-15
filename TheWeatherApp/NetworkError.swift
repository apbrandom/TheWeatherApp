//
//  NetworkError.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 15.09.2023.
//

import Foundation

enum NetworkError: Error {
    case badURL, badRequest, badResponse, invalidData, invalidDecoding
}

