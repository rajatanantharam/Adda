//
//  Contact.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 10/12/2017.
//  Copyright © 2017 Rajat Anantharam. All rights reserved.
//

import Foundation
import SwiftyJSON


class Contact {
    var name : String?
    var emailAddress : String?
    var id : String?
    
    init(contactJSON:JSON) {
        let name = contactJSON["displayName"].string
        let id = contactJSON["id"].string
        let email = contactJSON["mail"].string
        
        if let nameString = name, let idString = id, let emailString = email {
            self.id = idString
            self.name = nameString
            self.emailAddress = emailString
        }
    }
}
