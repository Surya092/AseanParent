//
//  ReachabilityHelper.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import Foundation
import ReachabilitySwift


protocol ReachabilityDelegate: class {
    func networkConnected()
}

class ReachabilityHelper: NSObject {
    
    //Create Shared instance of the Helper Class
    static let shared = ReachabilityHelper()
    
    //Delegate to Class to get Call Back
    weak var delegate: ReachabilityDelegate?
    
    //Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    //Local Variable to help Check Network Connectivity
    private var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    //Reachability Reference
    let reachability = Reachability()
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability?.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    @objc fileprivate func reachabilityChanged(notification: Notification) {
        if let reachability = notification.object as? Reachability {
            switch reachability.currentReachabilityStatus {
            case .reachableViaWWAN:
                reachabilityStatus = .reachableViaWWAN
                delegate?.networkConnected()
            case .reachableViaWiFi:
                reachabilityStatus = .reachableViaWiFi
                delegate?.networkConnected()
            case .notReachable:
                reachabilityStatus = .notReachable
            }
        }
    }
}

