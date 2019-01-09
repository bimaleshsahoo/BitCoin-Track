//
//  ViewController.swift
//  BitCoin Track
//
//  Created by Bimalesh Sahoo on 27/12/18.
//  Copyright © 2018 Bimalesh Sahoo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    @IBOutlet weak var bitcoinValue: UILabel!
    
    let bitcoin_URL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCINR"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPrice(url: bitcoin_URL)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func getPrice(url: String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Got Price!")
                let bitcoinPrice : JSON = JSON(response.result.value!)
//                DispatchQueue.main.async {
                    self.updatePriceData(json: bitcoinPrice)
//                }
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.bitcoinValue.text = "Connection Issues"
            }
        }
        
    }
    
    func updatePriceData(json: JSON) {
        
        if let tempPrice = json["last"].double {
            
            bitcoinValue.text = String(tempPrice)
            
        } else {
            bitcoinValue.text = "Price Unavailable"
        }
        
    }

}
