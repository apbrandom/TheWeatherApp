//
//  CoreDataService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 15.09.2023.
//

import CoreData
import UIKit

class CoreDataService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Пример функции для сохранения данных
    func saveWeather(_ weather: WeatherModel) {
        let context = context
        let entity = NSEntityDescription.entity(forEntityName: "WeatherData", in: context)!
        let newWeather = NSManagedObject(entity: entity, insertInto: context)

        newWeather.setValue(weather.now, forKey: "now")
        newWeather.setValue(weather.nowDt, forKey: "nowDt")
        // Установите все остальные поля...

        saveContext()
    }

    // Пример функции для извлечения данных
    func fetchWeather() -> WeatherModel? {
//        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherData")

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let now = data.value(forKey: "now") as! Int
                let nowDt = data.value(forKey: "nowDt") as! String
                // Извлеките все остальные поля...
                
                return WeatherModel(now: now, nowDt: nowDt, ...)
            }
        } catch {
            print("Fetching data failed")
            return nil
        }
        return nil
    }

    
}
