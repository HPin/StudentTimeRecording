//
//  DeadlinesViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 21.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

class DeadlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddDeadlineSubviewControllerDelegate {
   
    
    @IBOutlet weak var addDeadlineOverlay: UIView!
    
    var deadlines: Results<Deadline>!
    var deadlinesSorted: [Deadline] = []
    
    @IBOutlet weak var deadlineTableView: UITableView!
     let realmController = RealmController()
    
    lazy var addDeadlineOverlay_: AddDeadlineSubviewController = {
        let overlay = AddDeadlineSubviewController()
        overlay.deadlineViewController = self
        return overlay
    }()
    
    @IBAction func addDeadlineOverlay(_ sender: Any) {
        addDeadlineOverlay_.createOverlay()
    }
    
    func dismissTheOverlay() {
        
        addDeadlineOverlay_.dismissOverlay()
    }
    
    func reloadTableViewFromSub() {
        reloadTableView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //courseDetailsTableView.register(CourseDetailsTableViewCell.self, forCellReuseIdentifier: "courseDetailsCell")
        let cell = deadlineTableView.dequeueReusableCell(withIdentifier: "deadlineCell") as! DeadlinesTableViewCell
        
        var currentDeadline: Deadline
        
        if indexPath.section == 0 {
            if indexPath.row < deadlines.count {
                currentDeadline = deadlinesSorted[indexPath.row]
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                cell.deadlineCellName.text = currentDeadline.name
                cell.deadlineCellDate.text = dateFormatter.string(from: currentDeadline.date)
            } else {
                cell.deadlineCellName.text = "no data available"
                cell.deadlineCellDate.text = "n/V"
            }
        } else {
            cell.deadlineCellName.text = "no data available"
            cell.deadlineCellDate.text = "n/V"
        }
        
        
        cell.deadlineCellName.numberOfLines = 0
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        var currentDeadline: Deadline
        
        if indexPath.row < deadlines.count {
            currentDeadline = deadlinesSorted[indexPath.row]
            realmController.deleteDeadline(deadline: currentDeadline)
            
        }
        tableView.reloadData()
    }
    
    func reloadTableView() {
        deadlines = realmController.getAllDeadlines()
        
        deadlinesSorted = deadlines.sorted(by: {$0.date < $1.date})
        deadlineTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deadlineOverlaySegue" {
            if let sender = segue.destination as? AddDeadlineSubviewController {
                sender.delegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.deadlineTableView.delegate = self
        self.deadlineTableView.dataSource = self
        
        self.deadlineTableView.backgroundColor = UIColor.darkGray
        
        addDeadlineOverlay.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        
        reloadTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
