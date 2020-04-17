//
//  CreateGoalViewController.swift
//  goalpost-app
//
//  Created by Manoli on 15/04/2020.
//  Copyright © 2020 Manoli. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextButton.bindToKeyboard()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        goalTextView.delegate = self
    }
    
    @IBAction func shortTermButtonTapped(_ sender: Any) {
        goalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
    }
    
    @IBAction func longTermButtonTapped(_ sender: Any) {
        goalType = .longTerm
        shortTermButton.setDeselectedColor()
        longTermButton.setSelectedColor()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        print("NEXT Button Tapped")
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            let finishGoalViewController: FinishGoalViewController
            finishGoalViewController = storyboard?.instantiateViewController(withIdentifier: "FinishGoalViewControllerID") as! FinishGoalViewController
            finishGoalViewController.initData(description: goalTextView.text!, type: goalType)
            
//            present(finishGoalViewController, animated: true, completion: nil)
            presentingViewController?.presentSecondaryDetail(finishGoalViewController)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        /*
         Custom transition from Devslopes instructions
         Doesn't perform well with Xcode 11 in iOS 13
         dismissDetail()
         */
        
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
