//
//  RoomMapper.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 30/12/2017.
//  Copyright © 2017 Rajat Anantharam. All rights reserved.
//

import Foundation
import SwiftyJSON

class RoomMapper {
    
    static func getAvailableRoomNames(jsonResponse: JSON?) -> [String]? {
        
        guard let json = jsonResponse else {
            return nil
        }
        
        var rooms = [String]()
        
        if let meetingTimeSuggestions = json["meetingTimeSuggestions"].array {
            for suggestions in meetingTimeSuggestions {
                if let locations = suggestions["locations"].array {
                    for location in locations {
                        rooms.append(location["displayName"].stringValue)
                    }
                }
            }
        }
        
        return rooms
    }
}
