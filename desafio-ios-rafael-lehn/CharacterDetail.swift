//
//  CharacterDetail.swift
//  desafio-ios-rafael-lehn
//
//  Created by Webeleven on 13/03/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class CharacterDetail: UIViewController{
    
    var curriences = Currency()
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var ButtonHQ: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        let segue = UnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
        print(curriences.characterId)
        
    }
    
    func update(){
        self.characterName.text = curriences.name
        self.characterImage.kf.setImage(with: URL(string: curriences.thumbnail + "." + curriences.extensions))
        self.characterDescription.text = curriences.description
        
        if curriences.description == "" {
            characterDescription.text = "there is no description"
        }
        
        ButtonHQ.layer.cornerRadius = 10
        
        if loading.isHidden == false{

            loading.isHidden = true
            
        }
    }
    
    @IBAction func buttonHQ(_ sender: Any) {
        performSegue(withIdentifier: "goRareHQ", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as? rareHQ
        viewController?.id = curriences.characterId
    }
    
}
