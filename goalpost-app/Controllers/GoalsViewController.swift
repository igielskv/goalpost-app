//
//  GoalsViewController.swift
//  goalpost-app
//
//  Created by Manoli on 15/04/2020.
//  Copyright © 2020 Manoli. All rights reserved.
//

import UIKit
import CoreData

class GoalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(description: "Eat salad twice a weak", type: .shortTerm, goalProgress: 2)
        return cell
    }
}
