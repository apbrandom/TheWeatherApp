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
        let forecastsEntity = weatherEntity?.forecasts ?? ForecastsEntity(context: context)  // Добавлено
        
        weatherEntity?.nowDt = databaseModel.nowDt
        weatherEntity?.fact = factEntity
        weatherEntity?.forecasts = forecastsEntity
        
        factEntity.temp = databaseModel.fact.temp
        factEntity.feelsLike = databaseModel.fact.feelsLike
        
        // Заполнение или обновление сущности прогноза
        if let forecastsDatabaseModel = databaseModel.forecasts.first {  // Предполагаем, что есть хотя бы один прогноз
            forecastsEntity.sunrise = forecastsDatabaseModel.sunrise  // Добавлено
        }
        
        do {
            try context.save()
            print("CoreData: saving or updating successfully")
        } catch {
            print("Failed to save or update: \(error)")
        }
    }


    func fetchCachedWeather() -> WeatherDatabaseModel? {
        let request: NSFetchRequest<WeatherEntity> = WeatherEntity.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            if let weatherEntity = result.first {
                guard let factEntity = weatherEntity.fact else {
                    print("FactEntity is nil")
                    return nil
                }
                
                guard let forecastsEntity = weatherEntity.forecasts else {
                    print("ForecastsEntity is nil")
                    return nil
                }
                
                // Преобразование FactEntity в FactDatabaseModel
                let factDatabaseModel = FactDatabaseModel(temp: factEntity.temp, feelsLike: factEntity.feelsLike)
                
                // Преобразование ForecastsEntity в ForecastsDatabaseModel
                let forecastsDatabaseModel = ForecastsDatabaseModel(sunrise: forecastsEntity.sunrise ?? "")
                
                return WeatherDatabaseModel(
                    nowDt: weatherEntity.nowDt ?? "",
                    fact: factDatabaseModel,
                    forecasts: [forecastsDatabaseModel] // Так как forecasts в WeatherDatabaseModel это массив
                )
            }
            
        } catch {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }

}
