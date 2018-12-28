//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/28/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

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
        view.bindToKeyboard()
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
