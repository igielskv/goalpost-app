//
//  FinishGoalViewController.swift
//  goalpost-app
//
//  Created by Manoli on 16/04/2020.
//  Copyright © 2020 Manoli. All rights reserved.
//

import UIKit
import CoreData

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
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    /*
                     let goalsViewController = storyboard?.instantiateViewController(withIdentifier: "GoalsViewControllerID") as! GoalsViewController
                     goalsViewController.undoShow(action: "Goal Created")
                     */
                    
//                    dismiss(animated: true, completion: nil)
                    dismissDetail()
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> () ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        managedContext.undoManager = UndoManager()
        
        do{
            try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
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
