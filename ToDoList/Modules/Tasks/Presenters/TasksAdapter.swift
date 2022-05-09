//
//  TasksAdapter.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 05.05.2022.
//

import UIKit

final class TasksAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private weak var presenter: TasksPresenterProtocol?
    
    // MARK: - Initializers
    
    init(presenter: TasksPresenterProtocol?) {
        self.presenter = presenter
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Current Tasks" : "Completed Tasks"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter?.tasksList.currentTasks.count ?? 0
        } else {
            return presenter?.tasksList.completedTasks.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseID, for: indexPath) as! TasksTableViewCell
        let task = indexPath.section == 0 ? presenter?.tasksList.currentTasks[indexPath.row] : presenter?.tasksList.completedTasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = makeDoneContextualAction(at: indexPath)
        
        let configuration = UISwipeActionsConfiguration(actions: [doneAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = makeDeleteContextualAction(for: tableView, at: indexPath)
        let editAction = makeEditContextualAction(at: indexPath)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    // MARK: - Make UIContextualActions methods
    
    private func makeDeleteContextualAction(for tableView: UITableView, at indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self, weak tableView] _, _, _ in
            self?.presenter?.deleteTask(at: indexPath)
            tableView?.deleteRows(at: [indexPath], with: .automatic)
            self?.presenter?.setTableViewAppearance()
        }
        deleteAction.backgroundColor = .systemRed
        return deleteAction
    }
    
    private func makeEditContextualAction(at indexPath: IndexPath) -> UIContextualAction {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, _ in
            self?.presenter?.editTask(at: indexPath)
        }
        editAction.backgroundColor = .systemBlue
        return editAction
    }
    
    private func makeDoneContextualAction(at indexPath: IndexPath) -> UIContextualAction {
        let doneAction = UIContextualAction(style: .normal, title: "Done") { [weak self] _, _, _ in
            self?.presenter?.setTaskDone(at: indexPath)
        }
        doneAction.backgroundColor = .systemGreen
        return doneAction
    }
}
