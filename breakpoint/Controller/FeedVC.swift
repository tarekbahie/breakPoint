//
//  FirstViewController.swift
//  breakpoint
//
//  Created by tarek bahie on 12/25/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    var messageArray = [Message]()

    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray
            self.tableView.reloadData()
        }
    }

    @IBAction func createNewFeedPressed(_ sender: Any) {
        let createPost = storyboard?.instantiateViewController(withIdentifier: "CreatePostVC") as? CreatePostVC
        present(createPost!, animated: true, completion: nil)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else {
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
