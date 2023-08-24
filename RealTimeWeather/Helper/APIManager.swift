//
//  APIManager.swift
//  RealTimeWeather
//
//  Created by Pavan Thakkar on 24/08/23.
//

import Foundation

final class APIManager {
    static var shared = APIManager()
    private init() {
        
    }
//     temperature, weather condition, humidity, and wind speed
//    ?q=vastral&appid=7843bd522dc8d3174d5d7abe42ee1ece
    func fetchWeatherInformation(cityName: String, completion: @escaping (Result<WeatherInformation, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather") else {
            return
        }
        let parameters: [String: Any] = [
            "appid": "7843bd522dc8d3174d5d7abe42ee1ece",
            "q": "paldi"
        ]
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        var newUrl = components.url
        var urlRequest = URLRequest(url: newUrl!)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                return
            }
//            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
//                return
//            }
            do {
                let weather = try JSONDecoder().decode(WeatherInformation.self, from: data)
                completion(.success(weather))
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    func fetchWeatherInformationForFiveDays(cityName: String, completion: @escaping (Result<WeatherForFiveDays, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast") else {
            return
        }
        let parameters: [String: Any] = [
            "appid": "7843bd522dc8d3174d5d7abe42ee1ece",
            "q": "paldi"
        ]
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        var newUrl = components.url
        var urlRequest = URLRequest(url: newUrl!)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data, error == nil else {
                return
            }
//            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
//                return
//            }
            do {
                let weather = try JSONDecoder().decode(WeatherForFiveDays.self, from: data)
                completion(.success(weather))
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
