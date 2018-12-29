//
//  SecondViewController.swift
//  breakpoint
//
//  Created by tarek bahie on 12/25/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var groupsArray = [Group]()
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        let group = groupsArray[indexPath.row]
        cell.configureCell(withTitle: group.groupTitle, withDescription: group.groupDescription, andMembers: group.memberCount)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeed = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else{return}
        groupFeed.initData(forGroup: groupsArray[indexPath.row])
        presentDetail(groupFeed)
    }
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUP.observe(.value) { (snapShot) in
            DataService.instance.getAllGroups { (returnedGroupArray) in
                self.groupsArray = returnedGroupArray
                self.tableView.reloadData()
            }
        }
        
    }

    
    @IBAction func addGroupsBtnPressed(_ sender: Any) {
        let createGroups = storyboard?.instantiateViewController(withIdentifier: "CreateGroupsVC") as? CreateGroupsVC
        present(createGroups!, animated: true, completion: nil)
    }
    
    
   
    

}

