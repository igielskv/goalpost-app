//
//  GoalsViewController.swift
//  goalpost-app
//
//  Created by Manoli on 15/04/2020.
//  Copyright © 2020 Manoli. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var undoView: UIView!
    @IBOutlet var undoLabel: UILabel!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        print("View Will Appear")
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    func undoShow(action: String) {
        undoLabel.text = action
        undoView.isHidden = false
    }
    
    @IBAction func addGoalButtonTapped(_ sender: Any) {
        
        /*
         Custom transition from Devslopes instructions
         Doesn't perform well with Xcode 11 in iOS 13
         guard let createGoalViewController = storyboard?.instantiateViewController(withIdentifier: "CreateGoalViewControllerID") else { return }
         
         presentDetail(createGoalViewController)
         */
        
        let createGoalViewController: CreateGoalViewController
        createGoalViewController = storyboard?.instantiateViewController(withIdentifier: "CreateGoalViewControllerID") as! CreateGoalViewController
        
//        present(createGoalViewController, animated: true, completion: nil)
        presentDetail(createGoalViewController)
    }
    
    @IBAction func undoButtonTapped(_ sender: Any) {
        undoLastAction()
        fetchCoreDataObjects()
        tableView.reloadData()
        undoView.isHidden = true
    }
    
}

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalTableViewCell else { return UITableViewCell() }
        
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // 'UITableViewRowAction' was deprecated in iOS 13.0: Use UIContextualAction and related APIs instead.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.undoShow(action: "Goal Removed")
        }
        
        let addProgressAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.addProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        addProgressAction.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        
        return [deleteAction, addProgressAction]
    }
}

extension GoalsViewController {
    func addProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress.")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexPath.row])
        managedContext.undoManager = UndoManager()
        
        do {
            try managedContext.save()
            print("Successfully removed goal.")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func undoLastAction() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.undo()
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("Could not undo: \(error.localizedDescription)")
        }
    }
}
