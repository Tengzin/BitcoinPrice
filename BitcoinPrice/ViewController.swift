//
//  ViewController.swift
//  BitcoinPrice
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    //UIPickerView delegate methods
    // # of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // # of rows in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    // titles for the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    // what to do if row is chosen
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
    }
    // changing text color of picker
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: currencyArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
//    func getWeatherData(url: String, parameters: [String : String]) {
//        
//        Alamofire.request(url, method: .get, parameters: parameters)
//            .responseJSON { response in
//                if response.result.isSuccess {
//
//                    print("Sucess! Got the weather data")
//                    let weatherJSON : JSON = JSON(response.result.value!)
//
//                    self.updateWeatherData(json: weatherJSON)
//
//                } else {
//                    print("Error: \(String(describing: response.result.error))")
//                    self.bitcoinPriceLabel.text = "Connection Issues"
//                }
//            }
//
//    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
//    func updateWeatherData(json : JSON) {
//        
//        if let tempResult = json["main"]["temp"].double {
//        
//        weatherData.temperature = Int(round(tempResult!) - 273.15)
//        weatherData.city = json["name"].stringValue
//        weatherData.condition = json["weather"][0]["id"].intValue
//        weatherData.weatherIconName =    weatherData.updateWeatherIcon(condition: weatherData.condition)
//        }
//        
//        updateUIWithWeatherData()
//    }
//    




}

