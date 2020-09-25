//
//  SettingsIC.swift
//  wikiwiki WatchKit Extension
//
//  Created by Uygur Kıran on 9.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import WatchKit
import Foundation


class SettingsIC: WKInterfaceController {

    @IBOutlet weak var picker: WKInterfacePicker!
    @IBOutlet weak var doneBtn: WKInterfaceButton!
    
    let defaults = UserDefaults.standard
    let langs = ["English", "Français", "日本語", "Deutsch", "Español", "Italiano", "Русский", "中文", "Türkçe", "Português", "Dansk", "Suomi", "Nederlands", "Azərbaycanca"]
    var pick = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        var items: [WKPickerItem] = []
        
        for item in langs {
            items.append(pickerItem("\(item)"))
        }
        picker.setItems(items)
    }

    
    override func willActivate() {
        super.willActivate()
        
        let slc = defaults.integer(forKey: "lan")
        picker.setSelectedItemIndex(slc)
    }

    
    override func willDisappear() {
        super.willDisappear()
    }
    
    
    @IBAction func pickerAction(_ value: Int) {
        pick = value
    }
    
    
    @IBAction func doneTapped() {
        
        defaults.set(pick, forKey: "lan")
        
        if defaults.bool(forKey: "first") != false {
            defaults.set(false, forKey: "first")
        }

        self.dismiss()
    }
    
    
    //ITEM MODEL
    func pickerItem(_ txt: String) -> WKPickerItem {
        let pickerItem = WKPickerItem()
        pickerItem.title = txt
        
        return pickerItem
    }
    
    
}
