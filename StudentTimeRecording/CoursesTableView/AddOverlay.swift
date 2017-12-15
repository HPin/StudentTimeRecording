//
//  AddOverlay.swift
//  StudentTimeRecording
//
//  Created by HP on 14.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class AddOverlay : NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellID = "cellID"
    let cellHeight: CGFloat = 40
    var coursesTableViewController: CoursesTableViewController?
    
   
    let settings: [Setting] = {
        return [Setting(name: "settings", imageName: "collectionViewHeaderIcon"),
                Setting(name: "load", imageName: "collectionViewHeaderIcon"),
                Setting(name: "test", imageName: "collectionViewHeaderIcon")
                ]
    }()
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        
        let itemSize = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)  // not really necessary
        layout.itemSize = CGSize(width: itemSize, height: 40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
       
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    

    func showOverlay() {
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blackViewDisappear)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let cvHeight: CGFloat = CGFloat(settings.count) * cellHeight
            let cvYLocation = window.frame.height - cvHeight    // collection view on bottom
            //initially put collection view on bottom of window (->window.frame.height)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: cvHeight)
            
            blackView.frame = window.frame
            
            blackView.alpha = 0
            
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: cvYLocation, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
    }
    
    
    @objc func blackViewDisappear() {
        UIView.animate(withDuration: 0.8, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (_) in
            self.blackView.removeFromSuperview()
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OverlayCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            self.blackView.removeFromSuperview()
            
            let setting = self.settings[indexPath.item]

            self.coursesTableViewController?.showSettingsOverlay(setting: setting)
        }
        
    }
    
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(OverlayCell.self, forCellWithReuseIdentifier: cellID)
    }
    
}
