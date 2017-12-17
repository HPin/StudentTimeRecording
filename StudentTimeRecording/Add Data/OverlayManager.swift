//
//  OverlayManager.swift
//  StudentTimeRecording
//
//  Created by HP on 17.12.17.
//  Copyright © 2017 HPJS. All rights reserved.
//

import UIKit

class OverlayManager: NSObject {

    let blackView = UIView()
    let overlayView = OverlayView()
    
    func openOverlay() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.frame = window.frame
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOverlay)))
            
            
            
            
            window.addSubview(blackView)
            window.addSubview(overlayView)
            
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 1
            }
            
        }
    }
    
    @objc func dismissOverlay() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    
}
