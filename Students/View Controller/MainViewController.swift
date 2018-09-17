//
//  MainViewController.swift
//  Students
//
//  Created by Ilgar Ilyasov on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var sortSelector: UISegmentedControl!
    private var studentsTableViewController: StudentsTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchStudents { (students, error) in
            if let error = error {
                NSLog("Error fetching students: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.students = students ?? []
            }
        }
    }
    
    func updateSort() {
        var sortedStudents: [Student] = []
        
        if sortSelector.selectedSegmentIndex == 0 {
            sortedStudents = students.sorted(by: { $0.firstName < $1.firstName })
        } else {
            sortedStudents = students.sorted(by: { ($0.lastName ?? "") < ($1.lastName ?? "")})
        }
        studentsTableViewController.students = sortedStudents
    }

    @IBAction func sortStudents(_ sender: Any) {
        updateSort()
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededStudentsTVC" {
            guard let destinationVC = segue.destination as? StudentsTableViewController else { return }
            studentsTableViewController = destinationVC
        }
    }
    
    // Handle fetching students from the server
    
    private let networkClient = NetworkClient()
    
    // Data source for the tableView
    
    private var students: [Student] = [] {
        didSet {
            updateSort()
        }
    }
}
