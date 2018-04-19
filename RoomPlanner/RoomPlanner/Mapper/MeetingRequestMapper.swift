//
//  MeetingRequestMapper.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 01/01/2018.
//  Copyright © 2018 Rajat Anantharam. All rights reserved.
//

import Foundation
import SwiftyJSON

class MeetingRequestMapper {
    static func getMeetingRequest() -> String? {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:00:00"
        
        let startDate = Date()
        let startTime = dateFormatter.string(from: startDate)
        
        let calendar = Calendar.current
        guard let endDate = calendar.date(byAdding: .hour, value: 1, to: startDate) else {
            return nil
        }
        
        let endTime = dateFormatter.string(from: endDate)
        let meetingRequest = MeetingRequest(timeConstraint: TimeConstraint(start: TimeSlot(dateTime: startTime), end: TimeSlot(dateTime: endTime)))
        
        return getRequestBodyJSON(meetingRequest: meetingRequest)
    }
    
    fileprivate static func getRequestBodyJSON(meetingRequest: MeetingRequest) -> String? {
        let json: JSON = [
            "timeConstraint": [
                "timeslots": [
                    [
                        "start": [
                            "dateTime": meetingRequest.timeConstraint.timeSlots[0].dateTime,
                            "timeZone": meetingRequest.timeConstraint.timeSlots[0].timeZone
                        ],
                    
                        "end": [
                            "dateTime": meetingRequest.timeConstraint.timeSlots[1].dateTime,
                            "timeZone": meetingRequest.timeConstraint.timeSlots[1].timeZone
                        ]
                    ]
                ]
            ],
            "meetingDuration": "PT1H"
        ]
        return json.rawString()
    }
}
