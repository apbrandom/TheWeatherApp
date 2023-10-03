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
                    schemaVersion: 9,  // увеличьте это значение на 1 при каждой новой миграции
                    migrationBlock: { migration, oldSchemaVersion in
                        // код миграции
                        if oldSchemaVersion < 1 {

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
//                    print("--Realm Model: \(weatherModel)")
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
        existing.fact = newModel.fact
        existing.forecasts = newModel.forecasts
    }
    
    private func save(_ model: WeatherRealmModel, in realm: Realm) {
        realm.add(model)
    }
    
    func fetchCachedWeather() async throws -> WeatherRealmModel? {
        return realm?.objects(WeatherRealmModel.self).first
    }
}


