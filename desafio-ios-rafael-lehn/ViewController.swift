//
//  ViewController.swift
//  desafio-ios-rafael-lehn
//
//  Created by Webeleven on 11/03/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var load: UIActivityIndicatorView!
    
    var curriences = [Currency]()
    var selectedIndex = 0
    var numberoffset = 0
    var characterIdNumber = 0
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        let segue = UnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let characterCell = UINib(nibName: "characterCell", bundle: nil)
        tableview.register(characterCell, forCellReuseIdentifier: "characterGoalCell")
        tableview.rowHeight = 170
        tableview.estimatedRowHeight = 170
        
        Request()
        tableview.reloadData()
    }
    
    func Request(){

        curriences = [Currency]()
        
        let timeStamp = "1583951490"
        let keypublic = "5ecf657af4a5551d096d49e4f2ffc724"
        let hash = "06de60a1cb99dc30a2854659c63d6a42"
        
        let url = "https://gateway.marvel.com/v1/public/characters?ts=\(timeStamp)&apikey=\(keypublic)&hash=\(hash)&offset=\(numberoffset))"
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            if let locationJSON = response.value as? [String:Any] {
                let dados = locationJSON["data"] as! [String:Any]
                let results = dados["results"] as! [[String:Any]]
                
                for personagens in results{
                    let thumbnail = personagens["thumbnail"] as! [String:Any]
                    let currency = Currency(
                        
                        name: personagens["name"] as! String,
                        thumbnail: thumbnail["path"] as! String,
                        extensions: thumbnail["extension"] as! String,
                        description: personagens["description"] as! String,
                        characterId: personagens["id"] as! Int
                    )
                    self.characterIdNumber = currency.characterId
                    print(self.characterIdNumber)
                    self.curriences.append(currency)
                    print(self.curriences.count)
                }
                self.tableview.reloadData()
                print(self.numberoffset)
                if self.load.isHidden == false{
                    self.load.isHidden = true
                }
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goCharacterDetail"{
            let viewController = segue.destination as? CharacterDetail
            viewController?.curriences = curriences[self.selectedIndex]
            print(viewController?.curriences)
            
            
            
        }
    }
    
    
    @IBAction func leftButtonList(_ sender: Any) {
        if numberoffset != 0 {
            numberoffset = numberoffset - 20
            Request()
        }
    }
    @IBAction func rightButtonList(_ sender: Any) {
        numberoffset = numberoffset + 20
        Request()
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.curriences.count
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterCell = tableview.dequeueReusableCell(withIdentifier: "characterGoalCell", for: indexPath) as! characterCell
        let currences = curriences[indexPath.row]
        characterCell.updateInfo(goal: currences)
        return characterCell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "goCharacterDetail", sender: nil)
    }
}
