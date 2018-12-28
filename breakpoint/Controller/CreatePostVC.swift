//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/28/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var userImgLbl: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreatePostVC.handleClose))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(CreatePostVC.handleClose))
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(pan)
        sendBtn.bindToKeyboard()
    }
    @objc func handleClose(){
        view.endEditing(true)
        textView.text = "compose your feed here"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser != nil {
            userEmailLbl.text = Auth.auth().currentUser?.email
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "compose your feed here" {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true

                    print("there is an error !")
                }
                
            }
           
            
        }
    }
}
