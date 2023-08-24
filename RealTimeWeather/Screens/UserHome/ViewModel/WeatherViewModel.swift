//
//  WeatherViewmodel.swift
//  RealTimeWeather
//
//  Created by Pavan Thakkar on 24/08/23.
//

import Foundation

class WeatherViewModel {
    var weather: WeatherInformation?
    var weatherInformationForFiveDays: WeatherForFiveDays?
    var callback: ((DataFetchigStatus)-> Void)?
    var callbackForFiveDays: ((DataFetchigStatus)-> Void)?
    
    func fetchWeatherInformation(with cityName: String) {
        self.callback?(.loading)
        APIManager.shared.fetchWeatherInformation(cityName: cityName) { response in
            self.callback?(.stopLoading)
            switch response {
            case .success(let weather):
                self.weather = weather
                self.callback?(.dataLoaded)
            case .failure(let error):
                self.callback?(.errorMessage(error))
            }
            
        }
    }
    func fetchWeatherInformationForFiveDays(with cityName: String) {
        self.callback?(.loading)
        APIManager.shared.fetchWeatherInformationForFiveDays(cityName: cityName) { response in
            self.callbackForFiveDays?(.stopLoading)
            switch response {
            case .success(let weather):
                self.weatherInformationForFiveDays = weather
                self.callbackForFiveDays?(.dataLoaded)
            case .failure(let error):
                self.callbackForFiveDays?(.errorMessage(error))
            }
            
        }
    }
    
}

enum DataFetchigStatus {
    case loading
    case stopLoading
    case dataLoaded
    case errorMessage(Error?)
}
