//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/29/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTxtLbl: ColorTextField!
    
    @IBOutlet weak var endBtn: UIButton!
    
    var groupMessages = [Message]()
    
    var group : Group?
    func initData(forGroup group : Group){
        self.group = group
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(GroupFeedVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLbl.text = group?.groupTitle
        DataService.instance.getEmailfor(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUP.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(DesiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 {
                    let endIndex = IndexPath(row: self.groupMessages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex , at: .bottom, animated: true)
                }
            })
        }
        
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageTxtLbl.text != "" {
            messageTxtLbl.isEnabled = false
            endBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTxtLbl.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (complete) in
                if complete {
                    self.messageTxtLbl.text = ""
                    self.messageTxtLbl.isEnabled = true
                    self.endBtn.isEnabled = true
                }
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {
            return UITableViewCell()
        }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUserId(forUID: message.senderId) { (email) in
            cell.configureCell(image: UIImage(named: "defaultProfileImage")!, email: email, groupFeed: message.content)
        }
        return cell
    }
    
}
