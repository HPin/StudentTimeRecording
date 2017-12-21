//
//  AddCourseViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 10.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class AddCourseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, NewSemesterSubviewControllerDelegate {
   
    let realmController = RealmController()
    var semesters: Results<Semester>!
    var selectedSemester: Semester?
    
    var activeTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // pass reference to self into overlay, otherwise we encounter a nil object there
    lazy var addOverlay: NewSemesterSubViewController = {
        let overlay = NewSemesterSubViewController()
        overlay.addCourseViewController = self
        return overlay
    }()
    
    func refreshPicker() {
        semesterPicker.reloadAllComponents()
        
        if semesters.count >= 1 {
            selectedSemester = semesters[0]
        }
    }
    
    func dismissTheOverlay() {
        addOverlay.dismissOverlay()
    }
    
    @IBAction func newSemesterButton(_ sender: UIButton) {
        addOverlay.createOverlay()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newSemesterOverlaySegue" {
            if let sender = segue.destination as? NewSemesterSubViewController {
                sender.delegate = self
            }
        }
    }
    
    @IBOutlet weak var overlaySubview: UIView!
    
    @IBOutlet weak var semesterTextField: UITextField!
    
    @IBOutlet weak var semesterPicker: UIPickerView!
    
    @IBOutlet weak var abbreveationTextField: UITextField!
    
    @IBOutlet weak var addCourseTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)   // return from present modally
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if (addCourseTextField.text != "") {
            
            let courseName = addCourseTextField.text!
            let courseNameShort = abbreveationTextField.text!
            
            realmController.addCourse(name: courseName, nameShort: courseNameShort, semester: selectedSemester!)
            
            // return to course list
            //navigationController?.popViewController(animated: true) // show
            self.dismiss(animated: true, completion: nil)             // present modally
            
            addCourseTextField.text = "" // reset text field
        } else {
            let alert = UIAlertController(title: "ERROR", message: "You have to enter a course name first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return semesters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row < semesters.count {
            return semesters[row].name
        } else {
            return "no data available"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedSemester = semesters[row]
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let totalHeight = view.frame.height
        let textFieldY = textField.frame.origin.y
        let textFieldDistanceFromBottom = totalHeight - textFieldY
        
        let offset = 280 - textFieldDistanceFromBottom
        
        
        if offset > 0 {
            UIView.animateKeyframes(withDuration: 2.5, delay: 0.0, options: [], animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: offset + 30), animated: false)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: offset - 15), animated: false)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
                })
                
            }, completion: nil)
        } else {
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                    textField.transform = CGAffineTransform(translationX: 0, y: 10)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                    textField.transform = CGAffineTransform(translationX: 0, y: -5)
                })
                
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                    textField.transform = CGAffineTransform(translationX: 0, y: 0)
                })
                
            }, completion: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {

        semesters = realmController.getAllSemesters()
        
        if semesters.count >= 1 {
            selectedSemester = semesters[0]
        }
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        
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
