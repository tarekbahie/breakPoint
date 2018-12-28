//
//  SecondViewController.swift
//  breakpoint
//
//  Created by tarek bahie on 12/25/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func addGroupsBtnPressed(_ sender: Any) {
        let createGroups = storyboard?.instantiateViewController(withIdentifier: "CreateGroupsVC") as? CreateGroupsVC
        present(createGroups!, animated: true, completion: nil)
    }
    

}

