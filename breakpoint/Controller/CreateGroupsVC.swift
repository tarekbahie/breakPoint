//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/28/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var titleLbl: ColorTextField!
    @IBOutlet weak var descriptionLbl: ColorTextField!
    @IBOutlet weak var peopleLbl: ColorTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArray = [String]()
    var chosenName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleLbl.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        peopleLbl.addTarget(self, action: #selector(CreateGroupsVC.textFieldDidChange), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChange(){
        if peopleLbl.text == ""{
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: peopleLbl.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleLbl.text != "" && descriptionLbl.text != "" {
            DataService.instance.getIdsForUsername(forUsername: chosenName) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(forTitle: self.titleLbl.text!, withDescription: self.descriptionLbl.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated{
                    self.dismiss(animated: true, completion: nil)
                    } else{
                        let errorPopUp = UIAlertController(title: "Couldn't create group", message: "try again", preferredStyle: .actionSheet)
                        let errorAction = UIAlertAction(title: "retry", style: .default, handler: { (pressed) in
                            self.dismiss(animated: true, completion: nil)
                        })
                       errorPopUp.addAction(errorAction)
                        self.present(errorPopUp, animated: true, completion: nil)
                        
                    }
                })
                
            }
                
            }
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {
            return UITableViewCell()
        }
        if chosenName.contains(emailArray[indexPath.row]){
        cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: emailArray[indexPath.row], isSelected: true)
        }else {
        cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else{return}
        if !chosenName.contains(cell.emailLbl.text!){
        chosenName.append(cell.emailLbl.text!)
            membersLbl.text = chosenName.joined(separator: ", ")
            doneBtn.isHidden = false
        } else{
            chosenName = chosenName.filter({ $0 != cell.emailLbl.text! })
            if chosenName.count >= 1{
                membersLbl.text = chosenName.joined(separator: ", ")
                
            }else {
                membersLbl.text = "Insert emails here !"
                doneBtn.isHidden = true
            }
        }
    }
    

}
