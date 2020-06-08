//
//  TodosViewController.swift
//  TodoAPP
//
//  Created by Martin Nasierowski on 02/06/2020.
//  Copyright © 2020 Martin Nasierowski. All rights reserved.
//

import UIKit
import RealmSwift

final class TodosViewController: UIViewController {
    
    // MARK: - Variables
    fileprivate var tableView = UITableView()
    fileprivate let realm = try! Realm()
    fileprivate lazy var tasks: Results<Task> = { self.realm.objects(Task.self) }()

    // MARK: - Life cycle
    internal override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
                
        if tasks.count <= 0 {
            let noTaskAlert = UIAlertController(title: "You don't have any scheduled tasks", message: "", preferredStyle: .alert)
            noTaskAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(noTaskAlert, animated: true)
        }
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
       tableView.reloadData()
    }
    
    fileprivate func configureNavigation() {
        title = "To-do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.rightBarButtonItem?.tintColor = .white

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor =  .systemBlue
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    fileprivate func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.register(TaskCell.self, forCellReuseIdentifier: Cells.taskCell)
        tableView.layer.cornerRadius = 15
        tableView.pin(to: view)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    fileprivate func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc fileprivate func addTask() {
        let taskController = TaskViewController()
        taskController.delegate = self 
        navigationController?.pushViewController(taskController, animated: true)
    }
    

    fileprivate func removeTask(name: String) {
        guard let taskToDelete = tasks.filter("name = %@", name).first else { return }
        
        do {
            try realm.write {
                realm.delete(taskToDelete)
            }
        } catch {
            let failureAlert = UIAlertController(title: "Something went wrong", message: "", preferredStyle: .alert)
            failureAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(failureAlert, animated: true)
            print(error.localizedDescription)
        }
        
    }
}

// MARK: - TableView

extension TodosViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.taskCell) as! TaskCell
        cell.task = tasks[indexPath.row]
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            removeTask(name: tasks[indexPath.row].name)
            tableView.endUpdates()
        }
    }
}

// MARK: - ShowSuccessInfo

extension TodosViewController: ShowSuccessInfo {
    public func showSuccessInfo() {
        let successAlert = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(successAlert, animated: true)
    }
}
