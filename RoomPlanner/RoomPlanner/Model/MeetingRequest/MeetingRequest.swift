//
//  MeetingRequest.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 11/12/2017.
//  Copyright © 2017 Rajat Anantharam. All rights reserved.
//

import Foundation

class MeetingRequest {
    
    let timeConstraint : TimeConstraint
    let meetingDuration = "PT1H"
    
    init(timeConstraint : TimeConstraint) {
        self.timeConstraint = timeConstraint
    }
}
