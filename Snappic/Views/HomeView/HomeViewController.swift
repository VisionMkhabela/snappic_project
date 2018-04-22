//
//  HomeViewController.swift
//  Snappic
//
//  Created by Vision Mkhabela on 4/21/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts

class HomeViewController: UIViewController {
    
    @IBOutlet fileprivate var homeOutlets: HomeViewIBOutlets!

    //MARK: LifeCycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGesture()
    }
    
    //MARK: IBAction methods
    
    @IBAction func continueAction(_ sender: Any) {
        
        guard let startHour = self.homeOutlets.startHourTextField?.text , let endHour = self.homeOutlets.endHourTextField?.text else { return }
        guard let convertedStartHour = Double(startHour) else { return }
        guard let convertedEndHour = Double(endHour) else { return }
        
        if convertedStartHour < convertedEndHour {
            
            homeOutlets.streamingSessionHours.append(Session(startTime: convertedStartHour, endTime: convertedEndHour))
            self.drawChart(startTime: convertedStartHour, endTime: convertedEndHour)
            self.showDurations()
            self.view.endEditing(true)
            
        } else {
            
            self.homeOutlets.errorLabel.isHidden = false
            self.homeOutlets.errorLabel.text = Error_Message
            
        }
    }
    
    func clearStartEndTextFields() {
        homeOutlets.startHourTextField.text = ""
        homeOutlets.endHourTextField.text = ""
    }
    
    func showDurations() {
        homeOutlets.totalDurationLabel.text = Total_Duration + String(getTotalDuration())
        homeOutlets.effectiveDurationLabel.text = Effective_Duration + String(getEffectiveDuration())
        self.clearStartEndTextFields()
    }
    
    //MARK: Gesstures methods
    
    func addTapGesture() {
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGestureRecogniser)
    }
    
    //MARK: Keyboard notification methods
    
    @objc func dismissKeyboard (_ sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    //MARK: Duration Methods
    
    func getEffectiveDuration() -> Double {
        
        var overlappingDifference = 0.0
        
        let sortedArray = homeOutlets.streamingSessionHours.sorted(by:{ $0.startTime < $1.startTime })
        
        if sortedArray.count > 1 {
            for  index in 1..<sortedArray.count  {
                if (sortedArray[index-1].endTime > sortedArray[index].startTime) {
                    overlappingDifference = sortedArray[index-1].endTime - sortedArray[index].startTime
                }
            }
        } else {
            return getTotalDuration()
        }
        
        return getTotalDuration() - overlappingDifference
    }
    
    func getTotalDuration () -> Double {
        
        var totalDuration = 0.0
        
        for streamingSession in homeOutlets.streamingSessionHours {
            totalDuration += streamingSession.endTime - streamingSession.startTime
        }
        
        return totalDuration
    }
    
    //MARK: Chart methods
    
    func drawChart(startTime: Double, endTime: Double) {
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let readFormatter = DateFormatter()
        readFormatter.dateFormat = Date_Month_Year_Format
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = Date_Format
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        homeOutlets.chartBarCount -= 1
        homeOutlets.chartPoints.append(ChartPointCandleStick(date: date("\(homeOutlets.chartBarCount)"+".10.2015"), formatter: displayFormatter, high: 0, low: 0, open: endTime, close: startTime))
        
        let yValues = stride(from: 0, through: 23, by: 1).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)}
        
        let xGeneratorDate = ChartAxisValuesGeneratorDate(unit: .day, preferredDividers:2, minSpace: 1, maxTextSize: 12)
        let xLabelGeneratorDate = ChartAxisLabelsGeneratorDate(labelSettings: labelSettings, formatter: displayFormatter)
        let firstDate = date("01.10.2015")
        let lastDate = date("30.10.2015")
        let xModel = ChartAxisModel(firstModelValue: firstDate.timeIntervalSince1970, lastModelValue: lastDate.timeIntervalSince1970, axisTitleLabels: [ChartAxisLabel(text: "", settings: labelSettings)], axisValuesGenerator: xGeneratorDate, labelsGenerator: xLabelGeneratorDate)
        
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: XAxis_Label, settings: labelSettings.defaultVertical()))
        let chartFrame = ExamplesDefaults.chartFrame(homeOutlets.chartView.bounds)
        
        let chartSettings = ExamplesDefaults.chartSettings // for now zoom & pan disabled, layer needs correct scaling mode.
        let coordsSpace = ChartCoordsSpaceRightBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let chartPointsLineLayer = ChartCandleStickLayer<ChartPointCandleStick>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, chartPoints: homeOutlets.chartPoints, itemWidth: Env.iPad ? 10 : 5, strokeWidth: Env.iPad ? 1 : 0.6, increasingColor: UIColor.green, decreasingColor: UIColor.red)
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        let dividersSettings =  ChartDividersLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth, start: Env.iPad ? 7 : 3, end: 0)
        let dividersLayer = ChartDividersLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: dividersSettings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                dividersLayer,
                chartPointsLineLayer
            ]
        )
        
        homeOutlets.chartView.addSubview(chart.view)
        homeOutlets.chartView.clipsToBounds = true
        homeOutlets.chart = chart
    }

}
