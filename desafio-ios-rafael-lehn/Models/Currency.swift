//
//  Currency.swift
//  desafio-ios-rafael-lehn
//
//  Created by Webeleven on 12/03/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Currency {
    
    var name: String
    var thumbnail: String
    var extensions: String
    var description: String
    var characterId: Int
    
    init(name: String, thumbnail: String, extensions: String, description: String, characterId: Int) {
        self.name = name
        self.thumbnail = thumbnail
        self.extensions = extensions
        self.description = description
        self.characterId = characterId
    }
    
    init() {
        self.name = ""
        self.thumbnail = ""
        self.extensions = ""
        self.description = ""
        self.characterId = 0
    }
    
}
