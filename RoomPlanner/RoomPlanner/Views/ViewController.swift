//
//  ViewController.swift
//  RoomPlanner
//
//  Created by Rajat Anantharam on 15/11/2017.
//  Copyright © 2017 Rajat Anantharam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let service = OutlookService.shared()

    @IBOutlet var logInButton: UIButton!
    @IBOutlet var tableView: UITableView!

    private var availableRooms = [String]()
    let cellReuseIdentifier = "cell"

    @IBAction func logInButtonTapped(sender: AnyObject) {
        service.login(from: self) {
            error in
            if let unwrappedError = error {
                NSLog("Error logging in: \(unwrappedError)")
            } else {
                NSLog("Successfully logged in.")
                 self.getMeetingRooms()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI logic
        let loggedIn = service.isLoggedIn
        self.logInButton.isHidden = loggedIn
        self.tableView.isHidden = !loggedIn
       
        if (loggedIn) {
            getMeetingRooms()
        }
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availableRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let uiTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
            return UITableViewCell()
        }
        
        let cell:UITableViewCell = uiTableViewCell
        cell.textLabel?.text = self.availableRooms[indexPath.row]
        return cell
    }
    
    func initTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    func getMeetingRooms() {
        self.logInButton.isHidden = true
        self.tableView.isHidden = false
        
        guard let requestBody = MeetingRequestMapper.getMeetingRequest() else {
            return
        }
        service.getAvailableRooms(requestBody: requestBody) {
            (rooms) in
            if let result = rooms {
                self.availableRooms = result
                self.initTableView()
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            } else {
                NSLog("error")
            }
        }
    }
}

