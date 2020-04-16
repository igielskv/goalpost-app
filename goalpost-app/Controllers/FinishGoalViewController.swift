//
//  FinishGoalViewController.swift
//  goalpost-app
//
//  Created by Manoli on 16/04/2020.
//  Copyright © 2020 Manoli. All rights reserved.
//

import UIKit

class FinishGoalViewController: UIViewController {

    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createGoalButton.bindToKeyboard()
    }
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        goalDescription = description
        goalType = type
    }
    
    @IBAction func createGoalButtonTapped(_ sender: Any) {
        // Pass data to Core Data Goal Model
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
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
