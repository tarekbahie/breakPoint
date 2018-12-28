//
//  AuthVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/27/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func signInWithEmailPressed(_ sender: Any) {
        let loginVC = storyboard!.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
    }
    
    @IBAction func facebookSignInPressed(_ sender: Any) {
    }
}
