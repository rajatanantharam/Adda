//
//  StartTime.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 01/01/2018.
//  Copyright © 2018 Rajat Anantharam. All rights reserved.
//

import Foundation

class TimeSlot {
    
    var dateTime: String
    var timeZone: String
    
    init(dateTime: String) {
        self.dateTime = dateTime
        self.timeZone = "W. Europe Standard Time"
    }
}
