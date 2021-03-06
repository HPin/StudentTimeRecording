//
//  ChartsSubviewController.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

protocol ChartsSubviewControllerDelegate: class {
    func dismissTheOverlay()
    
    func reloadPieChart(course: Course)
    func reloadPieChart(semester: Semester)
    func reloadPieChart()
    func reloadLineChart(course: Course)
    func reloadLineChart(semester: Semester)
    func reloadLineChart()
}

class ChartsSubviewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var chartController: UISegmentedControl!
    
    var selectedCourse: Course?
    var selectedSemester: Semester?
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    weak var delegate: ChartsSubviewControllerDelegate?
    
    let blackView = UIView()
    
    var addCourseViewController: ChartsViewController?
    
    @IBAction func exitBtn(_ sender: Any) {
        
        delegate?.dismissTheOverlay()
    }
    
    
    func createOverlay() {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOverlay)))
        
        
        //window.addSubview(blackView)
        //window.addSubview((addCourseViewController?.overlaySubview)!)
        
        addCourseViewController?.view.addSubview(blackView)
        
        // add overlay after(!) black view
        addCourseViewController?.view.addSubview((
            addCourseViewController?.overlaySubview)!)
        
        blackView.frame = view.frame
        blackView.alpha = 0                 // set alpha to 0 for animation
        
        
        let overlayHeight: CGFloat = 300
        //overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            let overlayYLocation = self.view.frame.height - overlayHeight
            self.addCourseViewController?.overlaySubview.frame = CGRect(x: 0, y: overlayYLocation, width: self.view.frame.width, height: overlayHeight)
            
        }, completion: nil)
    }
    
    @objc func dismissOverlay() {
        
        //self.blackView.backgroundColor = UIColor.blue
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            self.addCourseViewController?.overlaySubview.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
            
        }) { (completed: Bool) in
            self.blackView.removeFromSuperview()
            
        }
    }
    
    @IBAction func chartControllerClicked(_ sender: Any) {
        
        if chartController.selectedSegmentIndex == 0{
            
            if picker.selectedRow(inComponent: 0) > 0{
                if picker.selectedRow(inComponent: 1) > 0 {
                    
                    delegate?.reloadPieChart(course: selectedCourse!)
                }
                else{
                    
                    delegate?.reloadPieChart(semester: selectedSemester!)
                }
            }
            else{
                delegate?.reloadPieChart()
            }
        }
        
        else if chartController.selectedSegmentIndex == 1{
            
            if picker.selectedRow(inComponent: 0) > 0{
                if picker.selectedRow(inComponent: 1) > 0 {
                    
                    delegate?.reloadLineChart(course: selectedCourse!)
                }
                else{
                    
                    delegate?.reloadLineChart(semester: selectedSemester!)
                }
            }
            else{
                delegate?.reloadLineChart()
            }
            
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return semesters.count + 1
        }
        else{
        
            let index = picker.selectedRow(inComponent: 0)
            if index > 0{
                
                selectedSemester = semesters[picker.selectedRow(inComponent: 0) - 1]
            return selectedSemester!.courses.count + 1
            }
            
            else {return 1}
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if component == 0 {
            if row == 0{
                return "---------"
            }
            else{
                return semesters[row-1].name
            }
        } else {
            if row == 0{
                return "---------"
            }
            else{
            let index = picker.selectedRow(inComponent: 0)
                if index > 0{
                    
                    selectedSemester = semesters[picker.selectedRow(inComponent: 0) - 1]
                    return selectedSemester!.courses[row-1].name
                }
                return ""
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if component == 0 {
            if row > 0 {
                selectedSemester = semesters[row-1]
                picker.selectRow(0, inComponent: 1, animated: true)
                selectedCourse = nil
                if chartController.selectedSegmentIndex == 0 {
                    
                    delegate?.reloadPieChart(semester: selectedSemester!)
                }
                else if chartController.selectedSegmentIndex == 1{
                    
                    delegate?.reloadLineChart(semester: selectedSemester!)
                }
            }
            else{
                selectedSemester = nil
                if chartController.selectedSegmentIndex == 0 {
                    
                    delegate?.reloadPieChart()
                }
                else if chartController.selectedSegmentIndex == 1{
                    
                    delegate?.reloadLineChart()
                }
            }
        } else {
            if row > 0 {
                selectedCourse = selectedSemester!.courses[row-1]
                if chartController.selectedSegmentIndex == 0 {
                    
                    delegate?.reloadPieChart(course: selectedCourse!)
                }
                else if chartController.selectedSegmentIndex == 1{
                    
                    delegate?.reloadLineChart(course: selectedCourse!)
                }
            }
            else{
                selectedCourse = nil
                if let sem = selectedSemester{
                    if chartController.selectedSegmentIndex == 0 {
                        
                        delegate?.reloadPieChart(semester: sem)
                    }
                    else if chartController.selectedSegmentIndex == 1{
                        
                        delegate?.reloadLineChart(semester: sem)
                    }
                }
            }
            
        }
        
        picker.reloadAllComponents()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        semesters = realmController.getAllSemesters()
        
        if semesters.count != 0{
            selectedSemester = semesters[0]
        }
        
         }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          }
 

}
