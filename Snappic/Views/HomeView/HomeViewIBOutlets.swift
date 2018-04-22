//
//  HomeIBOutlets.swift
//  Snappic
//
//  Created by Vision Mkhabela on 4/21/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts

class HomeViewIBOutlets: NSObject {
    
    @IBOutlet var startHourTextField: IBTextfield!
    @IBOutlet var endHourTextField: IBTextfield!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet weak var continueButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalDurationLabel: UILabel!
    @IBOutlet weak var effectiveDurationLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    
    var chart: Chart?
    var chartPoints = [ChartPointCandleStick]()
    var chartBarCount = 29
    var streamingSessionHours = [Session]()
    
}
