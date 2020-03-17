//
//  rareHQ.swift
//  desafio-ios-rafael-lehn
//
//  Created by Webeleven on 13/03/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher

class rareHQ: UIViewController{
    
    @IBOutlet weak var hqImage: UIImageView!
    @IBOutlet weak var hqTitle: UILabel!
    @IBOutlet weak var hqDesc: UILabel!
    @IBOutlet weak var hqPrice: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var hq = [Hq]()
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(id)
        
        Request()
    }
    
    
    func Request(){

            hq = [Hq]()
            
            let timeStamp = "1583951490"
            let keypublic = "5ecf657af4a5551d096d49e4f2ffc724"
            let hash = "06de60a1cb99dc30a2854659c63d6a42"
            
            let url = "https://gateway.marvel.com/v1/public/characters/\(id)/comics?ts=\(timeStamp)&apikey=\(keypublic)&hash=\(hash)"
            Alamofire.request(url).responseJSON(completionHandler: {
                response in
                if let locationJSON = response.value as? [String:Any] {
                    let dados = locationJSON["data"] as! [String:Any]
                    let results = dados["results"] as! [[String:Any]]
                    
                    for comic in results{
                        
                        let prices = comic["prices"] as! [[String:Any]]
                        let idComic = comic["id"] as! Int
                        
                        for priceComic in prices {
                            let priceComic2 = priceComic["price"] as! Double
                            
                            if priceComic2 >= priceComic2  {

                                for idConsult in results{
                                    let idConsulting = idConsult["id"] as! Int
                                    print(idConsulting)


                                        self.hqTitle.text = results[0]["title"] as? String ?? "there is no title"
                                        self.hqDesc.text = results[0]["description"] as? String ?? "there is no description"
                                        self.hqPrice.text = "US $\(priceComic2.description)" ?? "there is no price"
                                        let thumbnail = results[0]["images"] as! [[String:Any]]
                                        for image in thumbnail{
                                            let imagens = thumbnail[0]["path"] as! String
                                            let extensions = thumbnail[0]["extension"] as! String
                                            self.hqImage.kf.setImage(with: URL(string: imagens + "." + extensions))
                                        
                                    }
                                    if self.loading.isHidden == false{
                                        self.loading.isHidden = true
                                    }
                                    return
                                }

                            }
                            
                        }
                        
                    }

                }
            })
        }
    
}
