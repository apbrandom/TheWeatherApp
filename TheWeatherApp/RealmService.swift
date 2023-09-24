//
//  RealmService.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 21.09.2023.
//

import RealmSwift

class RealmService {
    
    private var realm: Realm? {
            do {
                let config = Realm.Configuration(
                    schemaVersion: 3,  // увеличьте это значение на 1 при каждой новой миграции
                    migrationBlock: { migration, oldSchemaVersion in
                        // код миграции
                        if oldSchemaVersion < 1 {
                            // В вашем случае новое поле forecasts было добавлено.
                            // Нет необходимости делать что-то специальное здесь,
                            // так как Realm автоматически обнаружит новое свойство и добавит его.
                        }
                    }
                )
                
                return try Realm(configuration: config)
            } catch {
                print("Failed to initialize Realm: \(error.localizedDescription)")
                return nil
            }
        }
    
    func saveOrUpdateWeather(_ weatherModel: WeatherRealmModel) async throws {
        do {
            guard let realm = self.realm else {
                return
            }
            
            try realm.write {
                if let existingWeatherModel = realm.objects(WeatherRealmModel.self).first {
                    update(existing: existingWeatherModel, with: weatherModel)
                    print("--Realm: Updated successfully")
                    print("--Realm Model: \(weatherModel)")
                } else {
                    save(weatherModel, in: realm)
                    print("--Realm: Saved successfully")
                }
            }
        } catch {
            print("Failed to save or update in Realm: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func update(existing: WeatherRealmModel, with newModel: WeatherRealmModel) {
        existing.nowDt = newModel.nowDt
        // Добавьте другие поля для обновления, если нужно
    }
    
    private func save(_ model: WeatherRealmModel, in realm: Realm) {
        realm.add(model)
    }
    
    func fetchCachedWeather() async throws -> WeatherRealmModel? {
        return realm?.objects(WeatherRealmModel.self).first
    }
}


