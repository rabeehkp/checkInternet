//
//  Check_InternetVC.swift
//  CheckInternet
//
//  Created by Rabeeh KP on 27/01/18.
//  Copyright © 2018 Rabeeh KP. All rights reserved.
//

import UIKit
import SystemConfiguration

class Check_InternetVC: UIViewController, URLSessionDelegate, URLSessionDataDelegate
 {
    //MARK: - Variables
    var storeInternetDown = InternetDown()
    var storeConneted = Connected()
    
    //Check Speed variables
    var startTime: CFAbsoluteTime!
    var stopTime: CFAbsoluteTime!
    var bytesReceived: Int!
    var speedTestCompletionHandler: ((_ megabytesPerSecond: Double?, _ error: NSError?) -> ())!

    
//    var check_Func = Checking_Internet_Functions()
    @IBOutlet weak var ShowTimeLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var networkStatus: UIView!
    @IBOutlet weak var check_Internet_Button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkStatus.layer.cornerRadius = 60
//        var runtimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(reloadView), userInfo: nil, repeats: true)
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager), name: .flagsChanged, object: Network.reachability)
        Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(Check_InternetVC.updateUserInterface), userInfo: nil, repeats: true)
        updateUserInterface()
        //Check internet speed
      testDownloadSpeedWithTimout(timeout: 5.0) { (megabytesPerSecond, error) -> () in
        print("\(megabytesPerSecond); \(error)")
        }
    }
    
    @IBAction func check_Internet(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyBoard.instantiateViewController(withIdentifier: "Internet_Down_TimingTblVC") as! Internet_Down_TimingTblVC
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    @objc func updateUserInterface() {
        guard let status = Network.reachability?.status else { return }
        switch status {
        case .unreachable:
            networkStatus.backgroundColor = UIColor.red
            statusLbl.text = " Internet UnReachable"
//            view.backgroundColor = .red
        case .wifi:
            networkStatus.backgroundColor = UIColor.green
            statusLbl.text = "connected Wifi"
            statusLbl.textColor = UIColor.white
        case .wwan:
            networkStatus.backgroundColor = UIColor.yellow
            statusLbl.text = "connected wwan"
            statusLbl.textColor = UIColor.blue
        }
        print("Reachability Summary")
        print("Status:", status)
        print("HostName:", Network.reachability?.hostname ?? "nil")
        print("Reachable:", Network.reachability?.isReachable ?? "nil")
        if Network.reachability?.isReachable == false {
            let date = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh-mm-ss dd-MM-yyyy"
            let dateString = dateFormatter.string(from: date as Date)
            ShowTimeLbl.text = dateString
            storeInternetDown.Store_InternetDown_Time(Time: dateString)
        }
        else{
            let date = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh-mm-ss dd-MM-yyyy"
            let dateString = dateFormatter.string(from: date as Date)
            ShowTimeLbl.text = "Connected"
           storeConneted.Store_InternetDown_Time(Time: dateString)
        }
        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
    }
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
        
        func testDownloadSpeedWithTimout(timeout: TimeInterval, completionHandler:@escaping (_ megabytesPerSecond: Double?, _ error: NSError?) -> ()) {
            let url = NSURL(string: "http://www.someurl.com/file")!
            
            startTime = CFAbsoluteTimeGetCurrent()
            stopTime = startTime
            bytesReceived = 0
            speedTestCompletionHandler = completionHandler
            
            let configuration = URLSessionConfiguration.ephemeral
            configuration.timeoutIntervalForResource = timeout
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
            session.dataTask(with: url as URL).resume()
        }
        
        func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
        {
            bytesReceived! += data.count
            stopTime = CFAbsoluteTimeGetCurrent()
        }
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)
        {
            let elapsed = stopTime - startTime
            guard elapsed != 0 && (error == nil || ((error! as NSError).domain == NSURLErrorDomain && error?._code == NSURLErrorTimedOut)) else{
                speedTestCompletionHandler(nil, error as? NSError)
                return
            }
            
            let speed = elapsed != 0 ? Double(bytesReceived) / elapsed / 1024.0 / 1024.0 : -1
            speedTestCompletionHandler(speed, error as? NSError)
        }

}
