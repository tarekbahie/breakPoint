//
//  DataService.swift
//  breakpoint
//
//  Created by tarek bahie on 12/27/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = Database.database().reference()
class DataService{
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    var REF_FEED: DatabaseReference{
        return _REF_FEED
    }
    var REF_GROUP: DatabaseReference{
        return _REF_GROUPS
    }
    func createDBUser(uid : String, userData : Dictionary<String,Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message : String, forUID uid : String, withGroupKey groupKey : String?, sendComplete : @escaping (_ status : Bool)->()){
        if groupKey != nil{
            REF_GROUP.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderId": uid])
            sendComplete(true)
        }
        
    }
    
    func getAllGroups(handler : @escaping (_ groups : [Group])->()){
        var groupsArray = [Group]()
        REF_GROUP.observeSingleEvent(of: .value) { (groupsSnapshot) in
            guard let groupsSnapshot = groupsSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for group in groupsSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as? [String]
                if (memberArray?.contains((Auth.auth().currentUser?.uid)!))!{
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let desc = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, description: desc, key: group.key, memberCount: (memberArray?.count)!, members: memberArray!)
                    groupsArray.append(group)
                }
        }
            handler(groupsArray)
        
            
        }
        
    }
    
    
    func getAllFeedMessages(handler : @escaping (_ messages : [Message])->()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else{ return }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.insert(message, at: 0)
            }
            handler(messageArray)
            
        }
        
    }
    
    func getAllMessagesFor(DesiredGroup : Group, handler : @escaping (_ messagesArray : [Message])->()){
        var messageArray = [Message]()
        REF_GROUP.child(DesiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else{ return }
            
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
                let groupMessage = Message(content: content, senderId: senderId)
                messageArray.append(groupMessage)
            }
            handler(messageArray)
            
        }
    
    
    
    
    
    }
    
    
    
    
    
    
    func getUserId(forUID uid : String, handler : @escaping(_ username : String)->()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else{return}
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getEmail(forSearchQuery query : String, handler : @escaping(_ emailArray : [String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else{return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    func getIdsForUsername(forUsername usernames : [String], handler : @escaping(_ uidArray : [String])->()){
        var idArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else{return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email){
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
        
    }
    func createGroup(forTitle title : String, withDescription description : String, forUserIds ids : [String], handler : @escaping(_ groupCreated : Bool)->()) {
        REF_GROUP.childByAutoId().updateChildValues(["title": title, "description": description,"members":ids])
        handler(true)
        
    }
    func getEmailfor(group : Group, handler : @escaping(_ emailArray : [String])->()){
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else{return}
            for user in userSnapshot {
                if group.members.contains(user.key){
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    
    
    
    
    
    
    
    
}
