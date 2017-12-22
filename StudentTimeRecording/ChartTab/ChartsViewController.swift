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
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    var selectedCourse: Course!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    
    func dismissTheOverlay() {
        addOverlay.dismissOverlay()
    }
    
    func reloadPieChart(course: Course) {
        pieChartView.isHidden = false
        lineChartView.isHidden = true
        updatePieChartWithData(course: course)
    }
    
    func reloadPieChart(semester: Semester) {
        pieChartView.isHidden = false
        lineChartView.isHidden = true
        updatePieChartWithData(semester: semester)
    }
    
    func reloadPieChart() {
        pieChartView.isHidden = false
        lineChartView.isHidden = true
        updatePieChartWithData()
    }
    
    func reloadLineChart(course: Course) {
        lineChartView.isHidden = false
        pieChartView.isHidden = true
        updateLineChartWithData(course: course)
    }
    
    func reloadLineChart(semester: Semester) {
        lineChartView.isHidden = false
        pieChartView.isHidden = true
        updateLineChartWithData(semester: semester)
    }
    
    func reloadLineChart() {
        lineChartView.isHidden = false
        pieChartView.isHidden = true
        updateLineChartWithData()
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
    
    func updateLineChartWithData() {
        var dataEntries: [ChartDataEntry] = []
        var workEntries: [myTime] = []
        semesters = realmController.getAllSemesters()
        
        for x in 0..<semesters.count{
            for i in 0..<semesters[x].courses.count {
                
                for j in 0..<semesters[x].courses[i].timeAtHome.count{
                   workEntries.append(semesters[x].courses[i].timeAtHome[j])
                }
                for k in 0..<semesters[x].courses[i].timeAtUniversity.count{
                    workEntries.append(semesters[x].courses[i].timeAtUniversity[k])
                }
                for l in 0..<semesters[x].courses[i].timeStudying.count{
                    workEntries.append(semesters[x].courses[i].timeStudying[l])
                }
                
            }
            
        }
        
        let workEntriesSorted = workEntries.sorted(by: {$0.date < $1.date})
        var totalTime: Int = 0
        for i in 0..<workEntriesSorted.count{
            
            //let timeIntervalForDate: TimeInterval = workEntriesSorted[i].date.timeIntervalSince1970
            totalTime = totalTime + (workEntriesSorted[i].hours*60) + workEntriesSorted[i].minutes
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(totalTime)/60.0)
            dataEntries.append(dataEntry)
            
        }

        let chartDataSet = LineChartDataSet(values: dataEntries, label: nil)
        chartDataSet.label = "Total time spend in hours"
        chartDataSet.colors = [NSUIColor.red]
        let chartData = LineChartData(dataSet: chartDataSet)
        
        if dataEntries.count > 0 {
            lineChartView.data = chartData
        }
        else{
            lineChartView.data = nil
        }
        
        
        
        headerLabel.text = "All Semesters"
        
        lineChartView.chartDescription?.text = nil
        lineChartView.animate(xAxisDuration: 1.0, easingOption: .easeOutBack)
        lineChartView.legendRenderer.computeLegend(data: chartData)
        
    }
    
    func updateLineChartWithData(semester: Semester) {
        var dataEntries: [ChartDataEntry] = []
        var workEntries: [myTime] = []
        
            for i in 0..<semester.courses.count {
                
                for j in 0..<semester.courses[i].timeAtHome.count{
                    workEntries.append(semester.courses[i].timeAtHome[j])
                }
                for k in 0..<semester.courses[i].timeAtUniversity.count{
                    workEntries.append(semester.courses[i].timeAtUniversity[k])
                }
                for l in 0..<semester.courses[i].timeStudying.count{
                    workEntries.append(semester.courses[i].timeStudying[l])
                }
                
            
        }
        
        let workEntriesSorted = workEntries.sorted(by: {$0.date < $1.date})
        var totalTime: Int = 0
        for i in 0..<workEntriesSorted.count{
            
            //let timeIntervalForDate: TimeInterval = workEntriesSorted[i].date.timeIntervalSince1970
            totalTime = totalTime + (workEntriesSorted[i].hours*60) + workEntriesSorted[i].minutes
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(totalTime)/60.0)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: nil)
        chartDataSet.label = "Total time spend for \(semester.name) in hours"
        chartDataSet.colors = [NSUIColor.red]
        let chartData = LineChartData(dataSet: chartDataSet)
        
        if dataEntries.count > 0 {
            lineChartView.data = chartData
        }
        else{
            lineChartView.data = nil
        }
        
        
        
        headerLabel.text = semester.name
        
        lineChartView.chartDescription?.text = nil
        lineChartView.animate(xAxisDuration: 1.0, easingOption: .easeOutBack)
        lineChartView.legendRenderer.computeLegend(data: chartData)
        
    }
    
    func updateLineChartWithData(course: Course) {
        var dataEntries: [ChartDataEntry] = []
        var workEntries: [myTime] = []
        
        
        for j in 0..<course.timeAtHome.count{
            workEntries.append(course.timeAtHome[j])
        }
        for k in 0..<course.timeAtUniversity.count{
            workEntries.append(course.timeAtUniversity[k])
        }
        for l in 0..<course.timeStudying.count{
            workEntries.append(course.timeStudying[l])
        }
        
        
        let workEntriesSorted = workEntries.sorted(by: {$0.date < $1.date})
        var totalTime: Int = 0
        for i in 0..<workEntriesSorted.count{
            
            //let timeIntervalForDate: TimeInterval = workEntriesSorted[i].date.timeIntervalSince1970
            totalTime = totalTime + (workEntriesSorted[i].hours*60) + workEntriesSorted[i].minutes
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(totalTime)/60.0)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: nil)
        chartDataSet.label = "Total time spend for \(course.name) in hours"
        chartDataSet.colors = [NSUIColor.red]
        let chartData = LineChartData(dataSet: chartDataSet)
        
        if dataEntries.count > 0 {
            lineChartView.data = chartData
        }
        else{
            lineChartView.data = nil
        }
        
        
        
        headerLabel.text = "Course: \(course.name)"
        
        lineChartView.chartDescription?.text = nil
        lineChartView.animate(xAxisDuration: 1.0, easingOption: .easeOutBack)
        lineChartView.legendRenderer.computeLegend(data: chartData)
        
    }
    
    
    func updatePieChartWithData() {
        var dataEntries: [ChartDataEntry] = []
        semesters = realmController.getAllSemesters()
        
        for x in 0..<semesters.count{
            var timeCourse = 0
            for i in 0..<semesters[x].courses.count {
                
                for j in 0..<semesters[x].courses[i].timeAtHome.count{
                    timeCourse = timeCourse + (semesters[x].courses[i].timeAtHome[j].hours*60) +
                    semesters[x].courses[i].timeAtHome[j].minutes
                }
                for k in 0..<semesters[x].courses[i].timeAtUniversity.count{
                    timeCourse = timeCourse + (semesters[x].courses[i].timeAtUniversity[k].hours*60) + semesters[x].courses[i].timeAtUniversity[k].minutes
                }
                for l in 0..<semesters[x].courses[i].timeStudying.count{
                    timeCourse = timeCourse + (semesters[x].courses[i].timeStudying[l].hours*60) + semesters[x].courses[i].timeStudying[l].minutes
                }
                
            }
            if timeCourse > 0 {
                let dataEntry = PieChartDataEntry()
                let timeCourseHours: Double
                timeCourseHours = Double(timeCourse)/60.0
                dataEntry.y = timeCourseHours
                
                dataEntry.label = semesters[x].name
                
                
                dataEntries.append(dataEntry)
            }
        }
            
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        if dataEntries.count > 0 {
            pieChartView.data = chartData
        }
        else{
            pieChartView.data = nil
        }
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        headerLabel.text = "All Semesters"
        
        pieChartView.chartDescription?.text =  "in hours"
        pieChartView.animate(xAxisDuration: 1.0, easingOption: .easeOutBack)
        pieChartView.legendRenderer.computeLegend(data: chartData)
        
    }
        
    
    func updatePieChartWithData(semester: Semester) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<semester.courses.count {
            
            var timeCourse = 0
            for j in 0..<semester.courses[i].timeAtHome.count{
                timeCourse = timeCourse + (semester.courses[i].timeAtHome[j].hours * 60) +
                semester.courses[i].timeAtHome[j].minutes
            }
            for k in 0..<semester.courses[i].timeAtUniversity.count{
                timeCourse = timeCourse + (semester.courses[i].timeAtUniversity[k].hours * 60) +
                semester.courses[i].timeAtUniversity[k].minutes
            }
            for l in 0..<semester.courses[i].timeStudying.count{
                timeCourse = timeCourse + (semester.courses[i].timeStudying[l].hours * 60) +
                semester.courses[i].timeStudying[l].minutes
            }
            if timeCourse > 0 {
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourse)/60.0
                dataEntry.label = semester.courses[i].name
                if timeCourse > 0{
                    dataEntries.append(dataEntry)
                }
            }
        }
        
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        if dataEntries.count > 0 {
            pieChartView.data = chartData
        }
        else{
            pieChartView.data = nil
        }
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        headerLabel.text = semester.name
        
        pieChartView.chartDescription?.text = "in hours"
        pieChartView.animate(xAxisDuration: 1.0, easingOption: .easeOutBack)
        pieChartView.legendRenderer.computeLegend(data: chartData)
    }
    
    func updatePieChartWithData(course: Course) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<3{
            
            if i == 0{
                var timeCourseHome = 0
                for j in 0..<course.timeAtHome.count{
                    timeCourseHome = timeCourseHome + (course.timeAtHome[j].hours * 60) +
                    course.timeAtHome[j].minutes
                }
                if timeCourseHome > 0 {
                    
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourseHome)/60.0
                dataEntry.label = "Time at Home in hours"
                
                    if timeCourseHome > 0{
                        dataEntries.append(dataEntry)
                    }
                }
            }
            else if i == 1{
                
                var timeCourseUni = 0
                for j in 0..<course.timeAtUniversity.count{
                    timeCourseUni = timeCourseUni + (course.timeAtUniversity[j].hours * 60) +
                    course.timeAtUniversity[j].minutes
                }
                if timeCourseUni > 0 {
                    
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourseUni)/60.0
                dataEntry.label = "Time at Uni in hours"
                
                    if timeCourseUni > 0{
                        dataEntries.append(dataEntry)
                    }
                }
            }
            else{
                var timeCourseStudy = 0
                for j in 0..<course.timeStudying.count{
                    timeCourseStudy = timeCourseStudy + (course.timeStudying[j].hours * 60) +
                    course.timeStudying[j].minutes
                }
                if timeCourseStudy > 0 {
                    
                let dataEntry = PieChartDataEntry()
                dataEntry.y = Double(timeCourseStudy)/60.0
                dataEntry.label = "Time studing in hours"
                
                    if timeCourseStudy > 0{
                        dataEntries.append(dataEntry)
                    }
                }
            }
          
            
            
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        if dataEntries.count > 0 {
            pieChartView.data = chartData
        }
        else{
            pieChartView.data = nil
        }
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        
        headerLabel.text = "Course: \(course.name)"
        
        pieChartView.chartDescription?.text = nil
        pieChartView.animate(xAxisDuration: 1.0, easingOption: .easeOutBack)
        pieChartView.legendRenderer.computeLegend(data: chartData)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self
        semesters = realmController.getAllSemesters()
        lineChartView.noDataText = "Please add some course time first"
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = true
        pieChartView.noDataText = "Please add some course time first"
        pieChartView.animate(xAxisDuration: 1.0, easingOption: .easeOutBack)
        //pieChartView.backgroundColor = UIColor.red
        pieChartView.holeColor = UIColor.darkGray
        
        overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        semesters = realmController.getAllSemesters()
        updatePieChartWithData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}
extension UIViewController: IAxisValueFormatter {
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MMM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

