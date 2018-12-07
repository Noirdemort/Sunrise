//
//  ViewController.swift
//  Sunrise
//
//  Created by Noirdemort on 04/11/18.
//  Copyright © 2018 Noirdemort. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBAction func cityName(_ sender: Any) {
        let url = "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition.text%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(cityName.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        loadUrl(url: url)
    }
    func loadUrl(url : String){
        do {
            let appURL = URL(string:url)!
            let data  = try Data(contentsOf: appURL)
            let json = try JSONSerialization.jsonObject(with:  data) as!  [String:Any]
            let query = json["query"] as! [String:Any]
            let res = query["results"] as! [String:Any]
            let channel = res["channel"] as! [String:Any]
            let item =  channel["item"] as! [String:Any]
            let condn = item["condition"] as! [String:Any]
            print(condn)
            let gcc = (condn["text"] as! String)
            result.text = "\(gcc)"
        } catch  {
            result.text = "cannot reach server"
        }
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            //or
            //self.view.endEditing(true)
            return true
        }
    }
    @IBAction func killKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}

