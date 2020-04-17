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
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetch { (complete) in
            if complete {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
        tableView.reloadData()
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
        present(createGoalViewController, animated: true, completion: nil)
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
}

extension GoalsViewController {
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
}
