//
//  characterCell.swift
//  desafio-ios-rafael-lehn
//
//  Created by Webeleven on 12/03/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class characterCell: UITableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    
    func updateInfo(goal: Currency){
        self.name.text = goal.name
        self.imagem.kf.setImage(with: URL(string: goal.thumbnail + "." + goal.extensions))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
