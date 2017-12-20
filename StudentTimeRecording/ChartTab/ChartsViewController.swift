//
//  ChartsViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class ChartsViewController: UIViewController, ChartsSubviewControllerDelegate{
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    var selectedCourse: Course!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    
    func dismissTheOverlay() {
        addOverlay.dismissOverlay()
    }
    
    func reloadChart(course: Course) {
        updateChartWithData(course: course)
    }
    
    func reloadChart(semester: Semester) {
        updateChartWithData(semester: semester)
    }
    
    func reloadChart() {
        updateChartWithData()
    }
    
    
    var chartsSubviewController: ChartsSubviewController!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chartsOverlaySegue" {
            if let sender = segue.destination as? ChartsSubviewController {
                sender.delegate = self
            }
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        print("start")
        
    }
    
    lazy var addOverlay: ChartsSubviewController = {
        let overlay = ChartsSubviewController()
        overlay.addCourseViewController = self
        return overlay
    }()
    
    
    @IBOutlet weak var overlaySubview: UIView!
    
    @IBAction func overLayBarButton(_ sender: UIBarButtonItem) {
        
        addOverlay.createOverlay()
    }
    
    
    func updateChartWithData() {
        var dataEntries: [ChartDataEntry] = []
        semesters = realmController.getAllSemesters()
        
        for x in 0..<semesters.count{
            var timeCourse = 0
            for i in 0..<semesters[x].courses.count {
                
                for j in 0..<semesters[x].courses[i].timeAtHome.count{
                    timeCourse = timeCourse + semesters[x].courses[i].timeAtHome[j].hours
                }
                for k in 0..<semesters[x].courses[i].timeAtUniversity.count{
                    timeCourse = timeCourse + semesters[x].courses[i].timeAtUniversity[k].hours
                }
                for l in 0..<semesters[x].courses[i].timeStudying.count{
                    timeCourse = timeCourse + semesters[x].courses[i].timeStudying[l].hours
                }
                
            }
            if timeCourse > 0 {
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourse)
                dataEntry.label = semesters[x].name
                
                dataEntries.append(dataEntry)
            }
        }
            
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChartView.data = chartData
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        headerLabel.text = "All Semesters"
        
        pieChartView.chartDescription?.text = nil
        pieChartView.animate(xAxisDuration: 1.0)
        pieChartView.legendRenderer.computeLegend(data: chartData)
        
    }
        
    
    func updateChartWithData(semester: Semester) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<semester.courses.count {
            
            var timeCourse = 0
            for j in 0..<semester.courses[i].timeAtHome.count{
                timeCourse = timeCourse + semester.courses[i].timeAtHome[j].hours
            }
            for k in 0..<semester.courses[i].timeAtUniversity.count{
                timeCourse = timeCourse + semester.courses[i].timeAtUniversity[k].hours
            }
            for l in 0..<semester.courses[i].timeStudying.count{
                timeCourse = timeCourse + semester.courses[i].timeStudying[l].hours
            }
            if timeCourse > 0 {
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourse)
                dataEntry.label = semester.courses[i].name
               
                dataEntries.append(dataEntry)
            }
        }
        
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChartView.data = chartData
    
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        headerLabel.text = semester.name
        
        pieChartView.chartDescription?.text = nil
        pieChartView.animate(xAxisDuration: 1.0)
        pieChartView.legendRenderer.computeLegend(data: chartData)
    }
    
    func updateChartWithData(course: Course) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<3{
            
            if i == 0{
                var timeCourseHome = 0
                for j in 0..<course.timeAtHome.count{
                    timeCourseHome = timeCourseHome + course.timeAtHome[j].hours
                }
                if timeCourseHome > 0 {
                    
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourseHome)
                dataEntry.label = "Time at Home"
                
                dataEntries.append(dataEntry)
                }
            }
            else if i == 1{
                
                var timeCourseUni = 0
                for j in 0..<course.timeAtUniversity.count{
                    timeCourseUni = timeCourseUni + course.timeAtUniversity[j].hours
                }
                if timeCourseUni > 0 {
                    
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourseUni)
                dataEntry.label = "Time at Uni"
                
                dataEntries.append(dataEntry)
                }
            }
            else{
                var timeCourseStudy = 0
                for j in 0..<course.timeStudying.count{
                    timeCourseStudy = timeCourseStudy + course.timeStudying[j].hours
                }
                if timeCourseStudy > 0 {
                    
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourseStudy)
                dataEntry.label = "Time studing"
                
                dataEntries.append(dataEntry)
                }
            }
          
            
            
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChartView.data = chartData
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        
        headerLabel.text = "Course: \(course.name)"
        
        pieChartView.chartDescription?.text = nil
        pieChartView.animate(xAxisDuration: 1.0)
        pieChartView.legendRenderer.computeLegend(data: chartData)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self
        semesters = realmController.getAllSemesters()
        pieChartView.noDataText = "Please add some course time first"
        pieChartView.animate(xAxisDuration: 2.0)
        
        


        overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        semesters = realmController.getAllSemesters()
        updateChartWithData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
extension UIViewController: IAxisValueFormatter {
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

