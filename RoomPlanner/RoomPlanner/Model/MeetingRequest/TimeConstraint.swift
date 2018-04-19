//
//  TimeConstraint.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 11/12/2017.
//  Copyright © 2017 Rajat Anantharam. All rights reserved.
//

import Foundation

class TimeConstraint {
    
    var timeSlots: [TimeSlot]
    
    init(start: TimeSlot, end: TimeSlot) {
        self.timeSlots = [start, end]
    }
}
