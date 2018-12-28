//
//  MeVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/27/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {
    @IBOutlet weak var userImgLbl: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser != nil {
            userEmailLbl.text = Auth.auth().currentUser?.email
        }
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        let logOutPopUp = UIAlertController(title: "Log Out", message: "Are You Sure ?", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { (buttonTapped) in
            do {
            try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
                
            }
    }
        logOutPopUp.addAction(logOutAction)
        present(logOutPopUp, animated: true, completion: nil)
}
    
}
