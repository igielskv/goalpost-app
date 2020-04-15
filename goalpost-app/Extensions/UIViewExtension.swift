//
//  UIViewExtension.swift
//  goalpost-app
//
//  Created by Manoli on 15/04/2020.
//  Copyright © 2020 Manoli. All rights reserved.
//

import UIKit

extension UIView {
    func bindToKeyboard() {
        // 'UIKeyboardWillChangeFrame' has been renamed to 'UIResponder.keyboardWillChangeFrameNotification'
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        // 'UIKeyboardAnimationDurationUserInfoKey' has been renamed to 'UIResponder.keyboardAnimationDurationUserInfoKey', same applies for keyboardAnimationCurveUserInfoKey
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // deltaY doesn't calculate properly on iPhones where Safe Area.bottom and it's Superview.bottom is not the same, like iPhones X and above
        
        let deltaY = endingFrame.origin.y - startingFrame.origin.y + 34 // +34 is iPhone X and above compensation, but have to find better solution than this
                
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
}
