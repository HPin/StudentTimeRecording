//
//  NewSemesterSubViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 17.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

protocol NewSemesterSubviewControllerDelegate: class {
    func dismissTheOverlay()
    func refreshPicker()
}
class NewSemesterSubViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: NewSemesterSubviewControllerDelegate?
    
    let blackView = UIView()

    var addCourseViewController: AddCourseViewController?
    
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    var selectedSemesterType: String = "Winter Semester"
    var selectedYear: String = "2017"
    
    let pickerWidth: CGFloat = 100
    let pickerHeight: CGFloat = 100
    
    let semesterType = ["Winter Semester", "Summer Semester"]
    let years = ["2017", "2018", "2019", "2020"]
    
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        delegate?.dismissTheOverlay()
    }
 
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let semesterName = "\(selectedSemesterType) \(selectedYear)"
        var alreadyExists = false
        
        semesters = realmController.getAllSemesters()
        for semester in semesters {
            if semester.name == semesterName {
                alreadyExists = true
            }
        }
        
        if !alreadyExists {
            realmController.addSemester(name: semesterName)
        } else {
            let alert = UIAlertController(title: "ERROR", message: "This semester exists already.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
        delegate?.dismissTheOverlay()
        delegate?.refreshPicker()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        var originalY = semesterPicker.frame.origin.y
//        semesterPicker.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180))
//        semesterPicker.frame = CGRect(x: -100, y: originalY, width: view.frame.width + 200, height: 100)
//
//        originalY = yearPicker.frame.origin.y
//        yearPicker.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180))
//        yearPicker.frame = CGRect(x: -100, y: originalY, width: view.frame.width + 200, height: 100)
        
    }

    /*
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight))
            
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
        
        let label  = UILabel(frame: CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight))
        label.text = "2005"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        
        view.addSubview(label)
        
        return view
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return semesterType.count
        } else {
            return years.count
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return semesterType[row]
        } else {
            return years[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let typeIndex = pickerView.selectedRow(inComponent: 0)
        selectedSemesterType = semesterType[typeIndex]
       
        let yearIndex = pickerView.selectedRow(inComponent: 1)
        selectedYear = years[yearIndex]
        
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
