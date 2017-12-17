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
class AddTimeSubViewController: UIViewController {
    
    weak var delegate: AddTimeSubViewControllerDelegate?
    var courseDetailsTableViewController: CourseDetailsTableViewController?
    let blackView = UIView()

    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    @IBOutlet weak var timeTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        delegate?.dismissTheOverlay()
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
//        let semesterName = "\(selectedSemesterType) \(selectedYear)"
//        realmController.addSemester(name: semesterName)
        
        delegate?.dismissTheOverlay()
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
        
        
        let overlayHeight: CGFloat = 300
        //overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            let overlayYLocation = self.view.frame.height - overlayHeight
            self.courseDetailsTableViewController?.addTimeSubView.frame = CGRect(x: 0, y: overlayYLocation, width: self.view.frame.width, height: overlayHeight)
            
        }, completion: nil)
    }
    
    @objc func dismissOverlay() {
        
        //self.blackView.backgroundColor = UIColor.blue
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            self.courseDetailsTableViewController?.addTimeSubView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
            
        }) { (completed: Bool) in
            self.blackView.removeFromSuperview()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
