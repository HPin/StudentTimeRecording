//
//  ChartsSubviewController.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

protocol ChartsSubviewControllerDelegate: class {
    func dismissTheOverlay()
}

class ChartsSubviewController: UIViewController {

    weak var delegate: ChartsSubviewControllerDelegate?
    
    let blackView = UIView()
    
    var addCourseViewController: ChartsViewController?
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBAction func typeSegmentedControl(_ sender: UISegmentedControl) {
    }
    
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        delegate?.dismissTheOverlay()
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
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
