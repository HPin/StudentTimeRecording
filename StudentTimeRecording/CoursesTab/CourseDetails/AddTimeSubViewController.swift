//
//  AddTimeSubViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 17.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddTimeSubViewControllerDelegate: class {
    func dismissTheOverlay()
}
class AddTimeSubViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    weak var delegate: AddTimeSubViewControllerDelegate?
    var courseDetailsTableViewController: CourseDetailsTableViewController?
    let blackView = UIView()

    @IBOutlet weak var nameTF: UITextField!
    
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    var selectedCourse: Course?
    var selectedDate: Date = Date()
    var selectedHours: Int = 0
    var selectedMinutes: Int = 0
    
    let pickerHours: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    let pickerMinutes: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
    
    @IBOutlet weak var timeTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.dismissTheOverlay()
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
//        let semesterName = "\(selectedSemesterType) \(selectedYear)"
//        realmController.addSemester(name: semesterName)
        
        let selectDate = datePicker.date
        
        switch timeTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            realmController.addTimeAtUniversity(name: nameTF.text!, date: datePicker.date, hours: selectedHours, minutes: selectedMinutes, course: self.selectedCourse!)
        case 1:
            realmController.addTimeAtHome(name: nameTF.text!, date: datePicker.date, hours: selectedHours, minutes: selectedMinutes, course: self.selectedCourse!)
        case 2:
            realmController.addTimeStudying(name: nameTF.text!, date: datePicker.date, hours: selectedHours, minutes: selectedMinutes, course: self.selectedCourse!)
        default:
            print("invalid segmented control index encountered")
        }
        
        
        
        
        delegate?.dismissTheOverlay()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerHours.count
        } else {
            return pickerMinutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(pickerHours[row]) + " hours"
        } else {
            return String(pickerMinutes[row]) + " minutes"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedHours = pickerHours[row]
        } else {
            selectedMinutes = pickerMinutes[row]
        }
    }
    
    
    func createOverlay() {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOverlay)))
        
        
        //window.addSubview(blackView)
        //window.addSubview((addCourseViewController?.overlaySubview)!)
        
        courseDetailsTableViewController?.view.addSubview(blackView)
        
        // add overlay after(!) black view
        courseDetailsTableViewController?.view.addSubview((
            courseDetailsTableViewController?.addTimeSubView)!)
        
        blackView.frame = view.frame
        blackView.alpha = 0                 // set alpha to 0 for animation
        
        
        let overlayHeight: CGFloat = 400
        //overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            let overlayYLocation = self.view.frame.height - overlayHeight
            self.courseDetailsTableViewController?.addTimeSubView.frame = CGRect(x: 0, y: overlayYLocation, width: self.view.frame.width, height: overlayHeight)
            
        }, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func dismissOverlay() {
        
        //self.blackView.backgroundColor = UIColor.blue
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            self.courseDetailsTableViewController?.addTimeSubView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 400)
            
        }) { (completed: Bool) in
            self.blackView.removeFromSuperview()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
