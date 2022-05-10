//
//  TasksListEditorViewController.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 09.02.2022.
//

import UIKit

// MARK: - Protocols

protocol TasksListEditorViewControllerProtocol: AnyObject, AlertDisplayer {
    var presenter: TasksListEditorPresenerProtocol? { get }
    
    func setTasksListToEdit(taskListName: String?)
}

final class TasksListEditorViewController: UIViewController,  TasksListEditorViewControllerProtocol {

    // MARK: - Private properties
    
    private let taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Localized.Placeholders.tasksListName
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.setTitle(Localized.Buttons.saveButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.animate()
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.setTitle(Localized.Buttons.cancelButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.animate()
        return button
    }()
    
    // MARK: - Properties
    
    var presenter: TasksListEditorPresenerProtocol?
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private methods
    
    @objc private func cancelButtonTapped() {
        presenter?.didEndEditing?(nil)
    }
    
    @objc private func saveButtonTapped() {
        let taskName = self.taskNameTextField.text
        self.presenter?.saveTasksList(with: taskName)
    }
    
    private func configureViewController() {
        addHideKeyboardGesture()
        view.backgroundColor = .white
    }
    
    private func configureTaskNameTextField() {
        taskNameTextField.delegate = self
    }
    
    private func layoutTaskNameTextField() {
        view.addSubview(taskNameTextField)
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.regular),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.regular),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.regular),
            taskNameTextField.heightAnchor.constraint(lessThanOrEqualToConstant: TextFieldSize.maxHeight)
        ])
    }
    
    private func layoutSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: ButtonSize.height),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.regular),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Padding.regular),
        ])
    }
    
    private func layoutCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: Padding.regular),
            cancelButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.regular),
            cancelButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor),
            cancelButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor)
        ])
    }
    
    private func setupUI() {
        configureViewController()
        configureTaskNameTextField()
        
        layoutTaskNameTextField()
        layoutSaveButton()
        layoutCancelButton()
    }
    
    // MARK: - TasksListEditorViewControllerProtocol methods
    
    func setTasksListToEdit(taskListName: String?) {
        taskNameTextField.text = taskListName
    }
}

// MARK: - UITextFieldDelegate

extension TasksListEditorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= MaxTextLenght.tasksListName
    }
}
