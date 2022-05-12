//
//  TasksListsAdapter.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 05.05.2022.
//

import UIKit

final class TasksListsAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private weak var presenter: TasksListsPresenterProtocol?
    
    // MARK: - Initializers
    
    init(presenter: TasksListsPresenterProtocol?) {
        self.presenter = presenter
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.tasksLists.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksListTableViewCell.reuseID, for: indexPath) as! TasksListTableViewCell
        let tasksList = presenter?.tasksLists[indexPath.row]
        cell.configure(with: tasksList)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
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
        let deleteAction = UIContextualAction(style: .normal, title: Localized.SwipeActions.delete) { [weak self, weak tableView] _, _, _ in
            self?.presenter?.deleteTasksList(at: indexPath.row)
            tableView?.deleteRows(at: [indexPath], with: .automatic)
            self?.presenter?.setTableViewAppearance()
        }
        deleteAction.backgroundColor = UIColor(named: "buttonRed")
        return deleteAction
    }
    
    private func makeEditContextualAction(at indexPath: IndexPath) -> UIContextualAction {
        let editAction = UIContextualAction(style: .normal, title: Localized.SwipeActions.edit) { [weak self] _, _, _ in
            if let tasksList = self?.presenter?.tasksLists[indexPath.row] {
                self?.presenter?.editTasksList?(tasksList)
            }
        }
        editAction.backgroundColor = UIColor(named: "buttonBlue")
        return editAction
    }
    
    private func makeDoneContextualAction(at indexPath: IndexPath) -> UIContextualAction {
        let doneAction = UIContextualAction(style: .normal, title: Localized.SwipeActions.done) { [weak self] _, _, _ in
            self?.presenter?.setTasksListDone(at: indexPath.row)
        }
        doneAction.backgroundColor = UIColor(named: "buttonGreen")
        return doneAction
    }
}
