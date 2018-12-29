//
//  UIViewController.swift
//  breakpoint
//
//  Created by tarek bahie on 12/29/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func presentDetail(_ viewControllerToPresent : UIViewController){
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
        
        
    }
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
