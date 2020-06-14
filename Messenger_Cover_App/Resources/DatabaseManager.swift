//
//  DatabaseManager.swift
//  Messenger_Cover_App
//
//  Created by Thien Tung on 6/13/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
}


//MARK: - Account Management
extension DatabaseManager {
    
    
    public func userExists(with email: String,
                           completion: @escaping (Bool) -> Void) {
        //function get data out of the database is a synchronous so need a completion block.
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { (snapshot) in
        // this snapshot has a value property opposite that can be optional if it doesn't exist
            //guard let foundEmail = snapshot.value as? String else {
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
        
        
    }
    
    
    //Insert new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
    }
}


struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
 //   let profilePictureUrl: String
}