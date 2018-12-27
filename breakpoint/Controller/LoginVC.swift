//
//  LoginVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/27/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailTxtField: ColorTextField!
    @IBOutlet weak var passwordTxtField: ColorTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTxtField.delegate = self

    }
    
    @IBAction func closeBtnPressede(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailTxtField.text != "" && passwordTxtField.text != ""{
            AuthService.instance.loginUser(withEmail: emailTxtField.text!, withPassword: passwordTxtField.text!) { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }else {
                    print(String(describing: loginError?.localizedDescription))
                }
                AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, withPassword: self.passwordTxtField.text!, userCreationComplete: { (success, registerationError) in
                    if success{
                        AuthService.instance.loginUser(withEmail: self.emailTxtField.text!, withPassword: self.passwordTxtField.text!, loginComplete: { (success
                            , nil) in
                            self.dismiss(animated: true, completion: nil)
                        })
                    } else {
                        print(String(describing: registerationError?.localizedDescription ))
                    }
                })
                
        }
        
        
    }

    }
}
extension LoginVC : UITextFieldDelegate{ }
