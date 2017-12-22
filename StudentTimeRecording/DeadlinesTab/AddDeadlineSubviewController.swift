//
//  AddDeadlineSubviewController.swift
//  StudentTimeRecording
//
//  Created by Jakob on 22.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddDeadlineSubviewControllerDelegate: class {
    func dismissTheOverlay()
    func reloadTableViewFromSub()
}
class AddDeadlineSubviewController: UIViewController, UITextFieldDelegate  {
   

    
    weak var delegate: AddDeadlineSubviewControllerDelegate?
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var deadlineViewController: DeadlinesViewController?
    let blackView = UIView()
    
    
    let realmController = RealmController()
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let newDeadline = Deadline()
        newDeadline.name = nameTF.text!
        newDeadline.date = datePicker.date
        
        realmController.addDeadline(deadline: newDeadline)
        
        textFieldShouldReturn(nameTF)
        delegate?.dismissTheOverlay()
        delegate?.reloadTableViewFromSub()
    }
    @IBAction func cancelBtn(_ sender: Any) {
        
        textFieldShouldReturn(nameTF)
        delegate?.dismissTheOverlay()
    }
    
   
    
    func createOverlay() {
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOverlay)))
        
        
        //window.addSubview(blackView)
        //window.addSubview((addCourseViewController?.overlaySubview)!)
        
        deadlineViewController?.view.addSubview(blackView)
        
        // add overlay after(!) black view
        deadlineViewController?.view.addSubview((
            deadlineViewController?.addDeadlineOverlay)!)
        
        blackView.frame = view.frame
        blackView.alpha = 0                 // set alpha to 0 for animation
        
        
        let overlayHeight: CGFloat = 400
        //overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            let overlayYLocation = self.view.frame.height - overlayHeight
            self.deadlineViewController?.addDeadlineOverlay.frame = CGRect(x: 0, y: overlayYLocation, width: self.view.frame.width, height: overlayHeight)
            
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
            
            self.deadlineViewController?.addDeadlineOverlay.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 400)
            
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
    

}
