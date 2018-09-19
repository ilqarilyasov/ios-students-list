//
//  MainViewController.swift
//  Students
//
//  Created by Ilgar Ilyasov on 9/19/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var sortSelector: UISegmentedControl!
    private var studentsTableViewController: StudentsTableViewController!
    private let networkClient = NetworkClient()
    private var students: [Student] = [] {
        didSet {
            updateSort()
        }
    }
    
    // MARK: - App lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fethcData { (students, error) in
            if let error = error {
                NSLog("Error getting students: \(error)")
                return
            }
            
            self.students = students ?? []
        }
    }
    
    @IBAction func sort(_ sender: Any) {
        updateSort()
    }
    
    private func updateSort() {
        DispatchQueue.main.async {
            let sortedStudents: [Student]
            if self.sortSelector.selectedSegmentIndex == 0 {
                sortedStudents = self.students.sorted { $0.firstName < $1.firstName }
            } else {
                sortedStudents = self.students.sorted { ($0.lastName ?? "") < ($1.lastName ?? "") }
            }
            self.studentsTableViewController.students = sortedStudents
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerSegue" {
            let studentsTableVC = segue.destination as! StudentsTableViewController
            studentsTableViewController = studentsTableVC
        }
    }
}
