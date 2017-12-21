//
//  DeadlinesViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 21.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

class DeadlinesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    
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
           
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
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
