//
//  UsersResponse.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 11/12/2017.
//  Copyright © 2017 Rajat Anantharam. All rights reserved.
//

import Foundation

class UsersReponse {
    var firstPage : Bool
    var contacts = [Contact]()
    var nextLink : String
    
    init(firstPage : Bool, contacts : [Contact], nextLink : String) {
        self.firstPage = firstPage
        self.contacts = contacts
        self.nextLink = nextLink
    }
}
