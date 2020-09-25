//
//  InterfaceController.swift
//  wikiwiki WatchKit Extension
//
//  Created by Uygur Kıran on 9.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON


class InputIC: WKInterfaceController {
    let id = "result"
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var micButton: WKInterfaceButton!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
                
        if defaults.bool(forKey: "first") != false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.presentController(withName: "settings", context: nil)
            }
        }
        
    }
    
    
    @IBAction func micTapped() {
        getInput()
    }
    
    @IBAction func settingsTapped() {
        self.presentController(withName: "settings", context: nil)
    }
    

    func getInput() {
        self.presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { (query) in
            
            if let query = query {
                let q = query[0] as! String
                
                WKInterfaceDevice.current().play(.success)
                
                self.getData(q)
            
            }
        }
    }
    
    
    func getData(_ query: String) {
        let lang = getLang()
        let url = "https://\(lang).wikipedia.org/w/api.php"
        
        let parameters : [String:String] = [
           "format" : "json",
           "action" : "query",
           "prop" : "extracts|pageimages",
           "exintro" : "",
           "explaintext" : "",
           "titles" : query,
           "indexpageids" : "",
           "redirects" : "1",
           "pithumbsize" : "300"
           ]
        
            AF.request(url, method: .get, parameters: parameters).validate().responseJSON { response in
            
            switch response.result {
            case .success:
                print(response)
                
                //data
                let wikiJSON : JSON = JSON(response.value!)
                let pageid = wikiJSON["query"]["pageids"][0].stringValue
                
                let txt = wikiJSON["query"]["pages"][pageid]["extract"].stringValue
                let imgURL = wikiJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                
                let context: [String] = [txt, imgURL]
                self.presentController(withName: self.id, context: context)
                
            case let .failure(error):
                print(error)
                AF.cancelAllRequests()
                
                let cantConnect = WKAlertAction(title: "Close", style: WKAlertActionStyle.default) { }
                self.presentAlert(withTitle: "[ ! Alert ]", message: "Cannot connect to the internet. Please check your internet connection and try again.", preferredStyle: WKAlertControllerStyle.alert, actions:[cantConnect])
                
            }
        
        }
        
    }
    
    
    func getLang() -> String {
        switch defaults.integer(forKey: "lan") {
        case 0:
            return "en"
        case 1:
            return "fr"
        case 2:
            return "ja"
        case 3:
            return "de"
        case 4:
            return "es"
        case 5:
            return "it"
        case 6:
            return "ru"
        case 7:
            return "zh"
        case 8:
            return "tr"
        case 9:
            return "pt"
        case 10:
            return "da"
        case 11:
            return "fi"
        case 12:
            return "nl"
        case 13:
            return "az"
        default:
            return "en"
        }
        
    }
    
} //classend
