//
//  CrazyData.swift
//  WheelyTest
//
//  Created by Anastasia Loginova on 12.04.17.
//  Copyright © 2017 Anastasia Loginova. All rights reserved.
//

import Foundation
import UIKit

class Crazy {
    var id: Int
    var title: String?
    var text: String?
    
    init(id: Int, title: String, text: String) {
        self.id = id
        self.title = title
        self.text = text
    }

    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let text = json["text"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.text = text
    }
}

