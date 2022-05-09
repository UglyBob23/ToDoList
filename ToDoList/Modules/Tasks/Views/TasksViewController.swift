//
//  TasksViewController.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import UIKit

// MARK: - Protocols

protocol TasksViewControllerProtocol: AnyObject, AlertDisplayer {
    var presenter: TasksPresenterProtocol? { get }
    
    func setTableViewAppearance(tasksIsEmpty: Bool)
    func addTaskButtonTapped()
    func updateUI()
}

final class TasksViewController: UIViewController, TasksViewControllerProtocol {
    
    // MARK: - Private properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.alpha = 0
        tableView.allowsSelection = false
        tableView.register(TasksTableViewCell.self,
                           forCellReuseIdentifier: TasksTableViewCell.reuseID)
        return tableView
    }()
    
    private let noTasksLabel: UILabel = {
        let label = UILabel()
        label.text = "Tasks list is empty."
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var adapter: TasksAdapter = {
        TasksAdapter(presenter: presenter)
    }()
    
    // MARK: - Properties
    
    var presenter: TasksPresenterProtocol?
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func configureViewController() {
        view.backgroundColor = .white
    }
    
    func setTableViewAppearance(tasksIsEmpty: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = tasksIsEmpty ? 0 : 1
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = adapter
        tableView.delegate = adapter
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func layoutNoTasksLabel() {
        noTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noTasksLabel)
        
        NSLayoutConstraint.activate([
            noTasksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.regular),
            noTasksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.regular),
            noTasksLabel.heightAnchor.constraint(lessThanOrEqualToConstant: LabelSize.maxHeight),
            noTasksLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupUI() {
        configureViewController()
        configureTableView()
        
        layoutNoTasksLabel()
        layoutTableView()
        
        presenter?.setTableViewAppearance()
    }
    
    // MARK: - TasksViewControllerProtocol methods
    
    @objc func addTaskButtonTapped() {
        presenter?.showTaskEditor?(nil)
    }
    
    @objc func editTaskButtonTapped() {
        tableView.isEditing.toggle()
    }
    
    func updateUI() {
        tableView.reloadData()
        presenter?.setTableViewAppearance()
    }
}
