//
//  OutputIC.swift
//  wikiwiki WatchKit Extension
//
//  Created by Uygur Kıran on 9.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import WatchKit
import Foundation
import SDWebImage


class OutputIC: WKInterfaceController {
    
    @IBOutlet weak var image: WKInterfaceImage!
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let context = context as! [String]
        
        self.image.sd_setImage(with: URL(string: context[1]))
        self.label.setText(context[0])

        if context[0] == "" {
            self.image.setHeight(120.0)
            self.image.setWidth(120.0)
            self.image.setImage(UIImage(named: "nope"))
            self.label.setText("There were no results matching the query.")
        }
       

    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
