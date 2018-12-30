//
//  FBPasswordCreateVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/30/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class FBPasswordCreateVC: UIViewController {
    
    @IBOutlet weak var PassTxtField: UITextField!
    @IBOutlet weak var ConfirmPassTxtField: UITextField!
    
    
    
    var email : String = ""
    
    func initData(withEmail email : String){
        self.email = email
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func createBtnPressed(_ sender: Any) {
        if PassTxtField.text != "" && ConfirmPassTxtField.text != "" {
                AuthService.instance.loginUser(withEmail: email, withPassword: PassTxtField.text!) { (success, loginError) in
                    if success{
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Can't login \(String(describing: loginError?.localizedDescription))")
                    }
                    AuthService.instance.registerFBUser(withEmail: self.email, withPassword: self.PassTxtField.text!, userCreationComplete: { (success, regError) in
                        if success {
                            AuthService.instance.loginUser(withEmail: self.email, withPassword: self.PassTxtField.text!, loginComplete: { (success, nil) in
                                self.dismiss(animated: true, completion: nil)
                            })
                        } else {
                            print("Can't register \(String(describing: regError?.localizedDescription))")
                        }
                    })
                }
            
        }
    }
    

}
