//
//  ScaleSegue.swift
//  desafio-ios-rafael-lehn
//
//  Created by Webeleven on 16/03/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit
class Segue: UIStoryboardSegue{
    
    override func perform() {
        scale()
    }
    
    func scale(){
        let topViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        topViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        
        containerView?.addSubview(topViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations:  {
            topViewController.view.transform = CGAffineTransform.identity
        }, completion:{ sucess in
            fromViewController.present(topViewController, animated: false, completion: nil)
        })
        
    }
}

class UnwindScaleSegue: UIStoryboardSegue{
    override func perform() {
        scale()
    }
    
    func scale(){
        let topViewController = self.destination
        let fromViewController = self.source
        
        fromViewController.view.superview?.insertSubview(topViewController.view, at: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations:  {
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        }, completion:{ sucess in
            fromViewController.dismiss(animated: false, completion: nil)
        })
        
    }
}
