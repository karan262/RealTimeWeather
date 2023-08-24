//
//  ViewController.swift
//  RealTimeWeather
//
//  Created by Pavan Thakkar on 24/08/23.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var currentWeatherview: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    
    var titleLabels: [String] = ["Humidity", "Tempreature", "Weather condition", "Wind Speed"]
    let viewModel: WeatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func citySubmittedAction(_ sender: Any) {
        
        guard let cityName = cityNameTextField.text, !cityName.isEmpty else {
            return
        }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.fetchWeatherInformation(with: cityName)
        viewModel.callback = {[weak self] response in
            guard let self else {
                return
            }
            switch response {
            case .loading:
                print("Loading")
            case .stopLoading:
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                }
                print("stopLoading")
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.currentWeatherview.isHidden = false
                    self.tableView.reloadData()
                    
                }
                self.viewModel.fetchWeatherInformationForFiveDays(with: cityName)
                self.viewModel.callbackForFiveDays = {
                    result in
                    switch result {
                        
                    case .loading:
                        print("Loading")
                    case .stopLoading:
                        print("Stop Loading")

                    case .dataLoaded:
                        print("**\(self.viewModel.weatherInformationForFiveDays) **")
                    case .errorMessage(let error):
                        print(error?.localizedDescription)
                    }
                }
//                self.setWeatherData()
            case .errorMessage(let error):
                print(error?.localizedDescription)
            }
        }
    }
}


extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = viewModel.weather {
            return 4
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            return UITableViewCell()
        }
        guard let weather = viewModel.weather else {
            return UITableViewCell()
            
        }
        switch indexPath.row {
        case 0:
            let message = "\(weather.main.humidity)"
            cell.configure(title: titleLabels[indexPath.row], message: message )
        case 1:
            let message = "\(weather.main.temp)"
            cell.configure(title: titleLabels[indexPath.row], message: message)
            print("1")
        case 2:
            let message = "\(weather.main.feelsLike)"
            cell.configure(title: titleLabels[indexPath.row], message: message)
            print("0")
        case 3:
            let message = "\(weather.wind.speed)"
            cell.configure(title: titleLabels[indexPath.row], message: message)
            print("1")
        
        default:
            print("0")
        }
//        cell.weather = viewModel.weather
        return cell
    }
}
//extension WeatherViewController {
//    func setWeatherData() {
//        guard let weather = viewModel.weather else {
//            return
//        }
//
//        DispatchQueue.main.async { [weak self] in
//
//            guard let self else {
//                return
//            }
//            self.parentStackView.isHidden = false
//            self.tempreatureInformationLabel.text = "\(weather.main.temp)"
//            self.weatherConditionLabel.text = "\(weather.weather.first?.description)"
//            self.humidityInformationLabel.text = "\(weather.main.humidity)"
//            self.wingSpeedLabel.text = "\(weather.wind.speed)"
//        }
//    }
//}


