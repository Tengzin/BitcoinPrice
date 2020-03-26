//
//  ViewController.swift
//  CryptoPrice
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
    let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    let cryptoArray = ["BTC", "ETH"]
    let cryptoIconArray = ["bitcoin", "eth"]
    
    var currCrypto = "BTC"
    var currCurrency = "AUD"
    var currSymbol = "$"

    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var cryptoPicker: UIPickerView!
    @IBOutlet weak var cryptoIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        cryptoPicker.delegate = self
        cryptoPicker.dataSource = self
//        cryptoIcon.image = UIImage(named: "eth")
    }
    
    //UIPickerView delegate methods
    // # of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // # of rows in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 { // currency picker
            return currencyArray.count
        }
        else {
            return cryptoArray.count
        }
    }
    // changing text color and titles of picker
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == currencyPicker {
            return NSAttributedString(string: currencyArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        else {
            return NSAttributedString(string: cryptoArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
    }
    // what to do if row is chosen
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 { // currency picker
            currCurrency = currencyArray[row]
            currSymbol = symbolArray[row]
        } else { // crypto picker
            currCrypto = cryptoArray[row]
            cryptoIcon.image = UIImage(named: cryptoIconArray[row])
        }
        let params : [String : String] = ["symbol" : currCrypto, "convert" : currCurrency]
        getPrice(url: baseURL, parameters: params)
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
                    self.updatePrice(priceJSON: priceJSON, crypto: self.currCrypto, currency: self.currCurrency)
                case let .failure(error):
                    print(error)
                    self.bitcoinPriceLabel.text = "Unable to connect"
                }
        }
    }
   
    //MARK: - JSON Parsing
    func updatePrice(priceJSON : JSON, crypto : String, currency : String) {
        let numPrice = Double(priceJSON["data"][crypto]["quote"][currency]["price"].stringValue)!
        let price = currSymbol + String(format: "%.2f", numPrice)
        print(price)
        self.bitcoinPriceLabel.text = price
    }
}

