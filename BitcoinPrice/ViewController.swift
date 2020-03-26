//
//  ViewController.swift
//  BitcoinPrice
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
    let headers: HTTPHeaders = [
        "X-CMC_PRO_API_KEY": "00c88654-b4ed-42f6-93d0-55c0c6d4863e"
    ]
    
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
        finalURL = baseURL
        let params : [String : String] = ["symbol" : "BTC", "convert" : currencyArray[row]]
        getPrice(url: finalURL, parameters: params)
    }
    // changing text color of picker
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: currencyArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
  
    //MARK: - Networking
    func getPrice(url: String, parameters : [String : String]) {
        AF.request(url, parameters: parameters, headers: headers)
            .responseJSON { response in
//                debugPrint(response)
                switch response.result {
                case .success:
                    print("Got price data")
                    let priceJSON = JSON(response.value!)
//                    print(priceJSON)
                    let currency = parameters["convert"]
                    let price = priceJSON["data"]["BTC"]["quote"][currency!]["price"].stringValue
                    print(price)
//                    self.updatePrice(json: priceJSON)
                    
                case let .failure(error):
                print(error)
                self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
    }
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
//    func updatePrice(json : JSON) {
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

