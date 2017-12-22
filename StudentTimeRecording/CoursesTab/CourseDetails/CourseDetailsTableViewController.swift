//
//  CourseDetailsTableViewController.swift
//  StudentTimeRecording
//
//  Created by HP on 15.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit
import RealmSwift

class CourseDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTimeSubViewControllerDelegate {
    
    
    let realmController = RealmController()
    var semesters: Results<Semester>!
    
    var selectedCourse: Course!

    @IBOutlet weak var courseDetailsTableView: UITableView!
    
    @IBOutlet weak var addTimeSubView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.courseDetailsTableView.delegate = self
        self.courseDetailsTableView.dataSource = self
        
        self.courseDetailsTableView.backgroundColor = UIColor.darkGray
        
        addTimeSubView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 400)
        
        reloadTableView()
    }
    
    // pass reference to self into overlay, otherwise we encounter a nil object there
    lazy var addTimeOverlay: AddTimeSubViewController = {
        let overlay = AddTimeSubViewController()
        overlay.courseDetailsTableViewController = self
        return overlay
    }()
    
    @IBAction func addNewTimeButton(_ sender: UIBarButtonItem) {
        addTimeOverlay.createOverlay()
    }
    
    func dismissTheOverlay() {
        addTimeOverlay.dismissOverlay()
    }
    
    func reloadTableViewSub() {
        reloadTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTimeOverlaySegue" {
            if let sender = segue.destination as? AddTimeSubViewController {
                sender.delegate = self
                sender.selectedCourse = self.selectedCourse
            }
        }
    }
    
    func reloadTableView() {
        semesters = realmController.getAllSemesters()
        courseDetailsTableView.reloadData()
    }
    
   
    
    // -------------------- create table view entries
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var isEmpty = true
        
        if selectedCourse.timeAtUniversity.count != 0 {
            isEmpty = false
        }

        if selectedCourse.timeAtHome.count != 0 {
            isEmpty = false
        }

        if selectedCourse.timeStudying.count != 0 {
            isEmpty = false
        }
        
        if isEmpty {
            return 0
        } else {
            return 3
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        myHeader.backgroundColor = UIColor.brown
        
        let title = UILabel()
        let sectionTitles = ["Time at University", "Time at Home", "Time for Studying"]
        title.text = sectionTitles[section]
        title.frame = CGRect(x: 45, y: 10, width: view.frame.width - 45, height: 30)
        title.font = UIFont.systemFont(ofSize: 30)
        title.textColor = UIColor.white
        myHeader.addSubview(title)
        
        return myHeader
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
//        print("---------timeatuni")
//        print(selectedCourse.timeAtUniversity.count)
//        print(selectedCourse.timeAtHome.count)
//        print(selectedCourse.timeStudying.count)
//
        if section == 0 {
            return selectedCourse.timeAtUniversity.count
        }
        if section == 1 {
            return selectedCourse.timeAtHome.count
        }
        if section == 2 {
            return selectedCourse.timeStudying.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //courseDetailsTableView.register(CourseDetailsTableViewCell.self, forCellReuseIdentifier: "courseDetailsCell")
        let cell = courseDetailsTableView.dequeueReusableCell(withIdentifier: "courseDetailsCell") as! CourseDetailsTableViewCell
        
        var currentTime: myTime
        
        if indexPath.section == 0 {
            if indexPath.row < selectedCourse.timeAtUniversity.count {
                currentTime = selectedCourse.timeAtUniversity[indexPath.row]
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                cell.coursesCellTextLabel.text = currentTime.name
                cell.dateTextLabel.text = dateFormatter.string(from: currentTime.date)
                cell.timeTextLabel.text = "\(currentTime.hours) h \(currentTime.minutes) min"
            } else {
                cell.coursesCellTextLabel.text = "no data available"
                cell.dateTextLabel.text = "n/V"
                cell.timeTextLabel.text = "n/V"
            }
        } else if indexPath.section == 1 {
            if indexPath.row < selectedCourse.timeAtHome.count {
                currentTime = selectedCourse.timeAtHome[indexPath.row]
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                cell.coursesCellTextLabel.text = currentTime.name
                cell.dateTextLabel.text = dateFormatter.string(from: currentTime.date)
                cell.timeTextLabel.text = "\(currentTime.hours) h \(currentTime.minutes) min"
            } else {
                cell.coursesCellTextLabel.text = "no data available"
                cell.dateTextLabel.text = "n/V"
                cell.timeTextLabel.text = "n/V"
            }
        } else if indexPath.section == 2 {
            if indexPath.row < selectedCourse.timeStudying.count {
                currentTime = selectedCourse.timeStudying[indexPath.row]
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .medium
                
                cell.coursesCellTextLabel.text = currentTime.name
                cell.dateTextLabel.text = dateFormatter.string(from: currentTime.date)
                cell.timeTextLabel.text = "\(currentTime.hours) h \(currentTime.minutes) min"
            } else {
                cell.coursesCellTextLabel.text = "no data available"
                cell.dateTextLabel.text = "n/V"
                cell.timeTextLabel.text = "n/V"
            }
        } else {
            cell.coursesCellTextLabel.text = "no data available"
            cell.dateTextLabel.text = "n/V"
            cell.timeTextLabel.text = "n/V"
        }
        
        
        cell.coursesCellTextLabel.numberOfLines = 0
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        var currentTime: myTime
        
        if indexPath.section == 0 {
            if indexPath.row < selectedCourse.timeAtUniversity.count {
                currentTime = selectedCourse.timeAtUniversity[indexPath.row]
                realmController.deleteTime(time: currentTime)

            }
        } else if indexPath.section == 1 {
            if indexPath.row < selectedCourse.timeAtHome.count {
                currentTime = selectedCourse.timeAtHome[indexPath.row]
                realmController.deleteTime(time: currentTime)

                
            }
        } else if indexPath.section == 2 {
            if indexPath.row < selectedCourse.timeStudying.count {
                currentTime = selectedCourse.timeStudying[indexPath.row]
                realmController.deleteTime(time: currentTime)
            }
        }
        
        tableView.reloadData()
       
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
