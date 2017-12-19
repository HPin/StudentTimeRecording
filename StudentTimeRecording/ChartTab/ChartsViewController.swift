//
//  ChartsViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

class ChartsViewController: UIViewController, ChartsSubviewControllerDelegate {
    
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    func dismissTheOverlay() {
        addOverlay.dismissOverlay()
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
        
        //self.overlaySubview.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
    }
    
    lazy var addOverlay: ChartsSubviewController = {
        let overlay = ChartsSubviewController()
        overlay.addCourseViewController = self
        return overlay
    }()
    
    //let blackView = UIView()
    
    @IBOutlet weak var overlaySubview: UIView!
    
    @IBAction func overLayBarButton(_ sender: UIBarButtonItem) {
        
        addOverlay.createOverlay()
        
//        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
//        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blackViewDisappear)))
//        blackView.frame = view.frame
//        blackView.alpha = 0
//
//
//        view.addSubview(blackView)
//        view.addSubview(overlaySubview)
//        //addChildViewController(ChartsSubviewController())
//        //view.addSubview(overlaySubview) // add overlay after(!) black view
//
//        let overlayHeight: CGFloat = 300
//        //overlaySubview.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
//
//        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.blackView.alpha = 1
//
//            let overlayYLocation = self.view.frame.height - overlayHeight
//            self.overlaySubview.frame = CGRect(x: 0, y: overlayYLocation, width: self.view.frame.width, height: overlayHeight)
//
//        }, completion: nil)
    }
    
//    @objc func blackViewDisappear() {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//
//            self.blackView.alpha = 0
//
//            self.overlaySubview.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 300)
//
//        }) { (completed: Bool) in
//            self.blackView.removeFromSuperview()
//
//            //self.coursesTableViewController?.showSettingsOverlay(setting: setting)
//        }
//
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        semesters = realmController.getAllSemesters()


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
