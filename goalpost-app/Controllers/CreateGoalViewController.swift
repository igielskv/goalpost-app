//
//  CreateGoalViewController.swift
//  goalpost-app
//
//  Created by Manoli on 15/04/2020.
//  Copyright © 2020 Manoli. All rights reserved.
//

import UIKit

class CreateGoalViewController: UIViewController {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func shortTermButtonTapped(_ sender: Any) {
    }
    
    @IBAction func longTermButtonTapped(_ sender: Any) {
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        /*
         Custom transition from Devslopes instructions
         Doesn't perform well with Xcode 11 in iOS 13
         dismissDetail()
         */
        
        dismiss(animated: true, completion: nil)
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
