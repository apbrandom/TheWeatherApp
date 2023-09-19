//
//  CoreDataService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 15.09.2023.
//

import CoreData
import UIKit

class CoreDataService {
    
    private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
    
    //  сохранения данных
    func saveWeather(_ databaseModel: WeatherDatabaseModel) {
        // Попытка найти существующую запись
        let request: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        var weatherEntity: WeatherEntity?
        
        do {
            let result = try context.fetch(request)
            weatherEntity = result.first
        } catch {
            print("Failed to fetch existing weather: \(error)")
        }
        
        // Если запись не найдена, создаем новую
        if weatherEntity == nil {
            weatherEntity = WeatherEntity(context: context)
        }
        
        // Заполнение или обновление сущности
        let factEntity = weatherEntity?.fact ?? FactEntity(context: context)
        weatherEntity?.now = databaseModel.now
        weatherEntity?.nowDt = databaseModel.nowDt
        weatherEntity?.fact = factEntity
        
        factEntity.temp = databaseModel.fact.temp
        factEntity.feelsLike = databaseModel.fact.feelsLike
        
        do {
            try context.save()
            print("CoreData: saving or updating successfully")
        } catch {
            print("Failed to save or update: \(error)")
        }
    }


    func fetchCachedWeather() -> WeatherDatabaseModel? {
        // Создаем запрос к CoreData
        let request: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        
        do {
            // Выполняем запрос и пытаемся получить данные
            let result = try context.fetch(request)
            
            // Проверяем, есть ли хотя бы одна запись
            if let weatherEntity = result.first {
                // Убеждаемся, что у WeatherEntity есть связанный FactEntity
                guard let factEntity = weatherEntity.fact else {
                    print("FactEntity is nil")
                    return nil
                }
                // Инициализируем нашу модель данных из сущностей CoreData
                let factDatabaseModel = FactDatabaseModel(temp: factEntity.temp, feelsLike: factEntity.feelsLike)
                
                return WeatherDatabaseModel(now: weatherEntity.now, nowDt: weatherEntity.nowDt ?? "", fact: factDatabaseModel)
            }
            
        } catch {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }


}
