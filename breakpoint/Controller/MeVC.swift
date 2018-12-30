//
//  MeVC.swift
//  breakpoint
//
//  Created by tarek bahie on 12/27/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messageArray = [Message]()
    var groupArray = [Group]()
    var groupMessages = [Message]()
    
    @IBOutlet weak var userImgLbl: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var uid : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getUID(forUsername: (Auth.auth().currentUser?.email)!) { (returnedID) in
            self.uid = returnedID
            DataService.instance.getMessagesFor(DesiredUser: self.uid, handler: { (returnedMessage) in
                self.messageArray = returnedMessage
                DataService.instance.REF_GROUP.observe(.value) { (snapShot) in
                    DataService.instance.getAllGroups { (returnedGroupArray) in
                        self.groupArray = returnedGroupArray
                        print("this one is groupArray : \(returnedGroupArray)")
                        for group in returnedGroupArray{
                            DataService.instance.getMessagesFor(DesiredGroup: group, andDesiredUser: self.uid, handler: { (returnedGroupFeed) in
                                self.groupMessages = returnedGroupFeed
                                self.messageArray.append(contentsOf: self.groupMessages)
                                print("this one is group feed : \(returnedGroupFeed)")
                                
                            })
                        }
                    }
                }
                
                self.tableView.reloadData()
            })
        }
        
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MeCell") as? MeCell else {
            return UITableViewCell()
        }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        DataService.instance.getUserId(forUID: message.senderId) { (returnedUsername) in
            cell.configureCell(profileImage: image!, email: returnedUsername , content: message.content)
        }
        
        return cell
    }
}
