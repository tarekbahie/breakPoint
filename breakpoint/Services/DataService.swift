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
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderId": uid])
            sendComplete(true)
        }
        
    }
    
    
    
    
    
    
    
    
    
}
