//
//  Env.swift
//  Snappic
//
//  Created by Vision Mkhabela on 4/20/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import UIKit

class Env {
    
    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
