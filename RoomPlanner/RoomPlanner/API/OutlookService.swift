//
//  OutlookService.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 15/11/2017.
//  Copyright © 2017 Rajat Anantharam. All rights reserved.
//

import Foundation
import p2_OAuth2
import SwiftyJSON

class OutlookService {
    
    private var userEmail : String
    private let userResponse = UsersReponse(firstPage: true, contacts: [Contact](), nextLink: "")
    
    // Configure the OAuth2 framework for Azure
    private static let oauth2Settings = [
        "client_id" : "{YOUR_APP_CLIENT_ID}",
        "authorize_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
        "token_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/token",
        "scope": "openid profile offline_access User.Read Calendars.Read User.ReadBasic.All Calendars.Read.Shared",
        "redirect_uris": ["{YOUR_APP_NAME}://oauth2/callback"],
        "verbose": true,
        ] as OAuth2JSON
    
    private static var sharedService: OutlookService = {
        let service = OutlookService()
        return service
    }()
    
    private let oauth2: OAuth2CodeGrant
    
    private init() {
        oauth2 = OAuth2CodeGrant(settings: OutlookService.oauth2Settings)
        oauth2.authConfig.authorizeEmbedded = true
        userEmail = ""
    }
    
    class func shared() -> OutlookService {
        return sharedService
    }
    
    var isLoggedIn: Bool {
        get {
            return oauth2.hasUnexpiredAccessToken() || oauth2.refreshToken != nil
        }
    }
    
    func handleOAuthCallback(url: URL) -> Void {
        oauth2.handleRedirectURL(url)
    }
    
    func login(from: AnyObject, callback: @escaping (String? ) -> Void) -> Void {
        oauth2.authorizeEmbedded(from: from) {
            result, error in
            if let unwrappedError = error {
                callback(unwrappedError.description)
            } else {
                if let unwrappedResult = result, let token = unwrappedResult["access_token"] as? String {
                    // Print the access token to debug log
                    NSLog("Access token: \(token)")
                    callback(nil)
                }
            }
        }
    }
    
    func logout() -> Void {
        oauth2.forgetTokens()
    }
    
    // at this point this function can return a list of names for available rooms
    func getAvailableRooms(requestBody: String, callback: @escaping ([String]?) -> Void) -> Void {
        makeApiCall(api: "/v1.0/me/findMeetingTimes", httpMethod: "POST", httpBody: requestBody) {
            result in
            if let unwrappedResult = result {
                callback(RoomMapper.getAvailableRoomNames(jsonResponse: unwrappedResult))
            }
        }
    }
    
    func makeApiCall(api: String, httpMethod: String = "GET", httpBody: String? = nil,
                     callback: @escaping (JSON?) -> Void) -> Void {

        guard let urlComponents =  URLComponents(string: "https://graph.microsoft.com") else {
            return
        }
        
        var urlBuilder = urlComponents
        urlBuilder.path = api
        
        guard let requestUrl = urlBuilder.url else {
            return;
        }
        
        var req = oauth2.request(forURL: requestUrl)
        req.httpMethod = httpMethod
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let postBody = httpBody {
            req.httpBody = postBody.data(using: .utf8)
            req.addValue("application/json", forHTTPHeaderField: "Content-type")
        }

        let loader = OAuth2DataLoader(oauth2: oauth2)
        
        // Uncomment this line to get verbose request/response info in
        // Xcode output window
        loader.logger = OAuth2DebugLogger(.trace)
                
        loader.perform(request: req) {
            response in
            do {
                let dict = try response.responseJSON()
                DispatchQueue.main.async {
                    let result = JSON(dict)
                    callback(result)
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    let result = JSON(error)
                    callback(result)
                    NSLog(error.localizedDescription)
                }
            }
        }
    }
}
