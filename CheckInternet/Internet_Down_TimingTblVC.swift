//
//  Internet_Down_TimingTblVC.swift
//  CheckInternet
//
//  Created by Rabeeh KP on 27/01/18.
//  Copyright © 2018 Rabeeh KP. All rights reserved.
//

import UIKit

class Internet_Down_TimingTblVC: UITableViewController {

    var internetDownResults = [InternetDown]()
    var connectedTimeResult = [Connected]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backToMain()
        self.fetch_InternetDown_Time()
        tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      //  return 1
       return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        return internetDownResults.count
        }
        else{
           return connectedTimeResult.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "internet_Down_Cell", for: indexPath) as! Internet_Down_TimingCell
            cell.internetDown_TimeLbl.text = internetDownResults[indexPath.row].downTime
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "connectedTimeCell", for: indexPath) as! ConnectedTimeCell
        cell.internetConnected_TimeLbl.text = connectedTimeResult[indexPath.row].connectedTime
            return cell
        default: let cell = UITableViewCell()
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
        return "Internet down Time"
        }
        else{
        return "ReConnected Time "
        }
        
    }
 

    func fetch_InternetDown_Time(){
        let  internetDownTime = InternetDown()
        let internet_Connected = Connected()
        connectedTimeResult = internet_Connected.fetch_InternetConnected_Times()!
        internetDownResults = internetDownTime.fetch_InternetDown_Times()!
        tableView.reloadData()
    }

    func backToMain(){
        navigationItem.leftBarButtonItem?.title = "Back"
        self.title = "History"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        tableView.tableFooterView = UIView()
    }
}
