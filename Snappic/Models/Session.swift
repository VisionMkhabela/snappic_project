//
//  Session.swift
//  Snappic
//
//  Created by Vision Mkhabela on 4/22/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation

class Session: NSObject {
    
    var startTime: Double
    var endTime: Double
    
    init(startTime: Double, endTime: Double) {
        self.startTime = startTime
        self.endTime = endTime
    }
}
