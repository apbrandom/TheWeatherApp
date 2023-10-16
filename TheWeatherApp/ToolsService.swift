//
//  ToolsService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 14.10.2023.
//

import Foundation

struct ToolsService {
    static func convertDateWithFormater(from isoDate: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: isoDate) else {
            print("Bad iso date format")
            return nil
        }
        
        let formartter = DateFormatter()
        formartter.locale = Locale(identifier: "ru_RU")
        formartter.dateFormat = "HH:mm, EEE d MMM"
        
        let resultDate = formartter.string(from: date)
        return resultDate
    }
    
    static func convertHour(_ hour: String) -> String {
        if let hourInt = Int(hour) {
            return String(format: "%02d:00", hourInt)
        }
        return "Invalid hour"
    }
}
