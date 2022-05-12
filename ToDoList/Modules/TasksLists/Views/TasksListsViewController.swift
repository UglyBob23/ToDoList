//
//  TasksListsViewController.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 02.02.2022.
//

import UIKit

// MARK: - Protocols

protocol TasksListsViewControllerProtocol: AnyObject, AlertDisplayer {
    var presenter: TasksListsPresenterProtocol? { get }
    
    func setTableViewAppearance(tasksListsIsEmpty: Bool)
    func updateUI()
}

final class TasksListViewController: UIViewController, TasksListsViewControllerProtocol {
    
    // MARK: - Private properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "background")
        tableView.register(TasksListTableViewCell.self,
                           forCellReuseIdentifier: TasksListTableViewCell.reuseID)
        return tableView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Localized.SegmentedControl.alphabetItem, Localized.SegmentedControl.dateItem])
        segmentedControl.addTarget(self, action: #selector(updateUI), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let noTasksListsLabel: UILabel = {
        let label = UILabel()
        label.text = Localized.Labels.noTasksListsLabel
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var adapter: TasksListsAdapter = {
        TasksListsAdapter(presenter: presenter)
    }()
    
    // MARK: - Properties
    
    var presenter: TasksListsPresenterProtocol?
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        presenter?.fetchTasksLists()
    }
    
    // MARK: - Private methods
    
    private func sortTasksLists() {
        switch  segmentedControl.selectedSegmentIndex {
        case 0:
            presenter?.tasksLists.sort {
                $0.name.caseInsensitiveCompare($1.name) == .orderedAscending
            }
        case 1:
            presenter?.tasksLists.sort(by: { $0.date > $1.date })
        default:
            break
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = UIColor(named: "background")
    }
    
    private func configureTableView() {
        tableView.dataSource = adapter
        tableView.delegate = adapter
    }
    
    func setTableViewAppearance(tasksListsIsEmpty: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = tasksListsIsEmpty ? 0 : 1
        }
    }
    
    private func layoutNoTasksListsLabel() {
        noTasksListsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noTasksListsLabel)
        
        NSLayoutConstraint.activate([
            noTasksListsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.regular),
            noTasksListsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.regular),
            noTasksListsLabel.heightAnchor.constraint(lessThanOrEqualToConstant: LabelSize.maxHeight),
            noTasksListsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func layoutSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.regular),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.regular),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.regular)
        ])
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: Padding.regular),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        configureViewController()
        configureTableView()
        
        layoutSegmentedControl()
        layoutNoTasksListsLabel()
        layoutTableView()
    }
    
    // MARK: - Methods
    
    @objc func addButtonTapped() {
        presenter?.addTaskList?()
    }

    // MARK: - TasksListViewControllerProtocol methods
    
    @objc func updateUI() {
        sortTasksLists()
        tableView.reloadData()
        presenter?.setTableViewAppearance()
    }
}
