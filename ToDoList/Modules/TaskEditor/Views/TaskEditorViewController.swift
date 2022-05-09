//
//  TaskEditorViewController.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 12.02.2022.
//

import UIKit

// MARK: - Protocols

protocol TaskEditorViewControllerProtocol: AnyObject, AlertDisplayer {
    var presenter: TaskEditorPresenterProtocol? { get }
    
    func setTaskToEdit(taskName: String?, taskNote: String?)
}

final class TaskEditorViewController: UIViewController, TaskEditorViewControllerProtocol {
    
    // MARK: - Private properties
    
    private let taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.borderStyle = .roundedRect
        textField.placeholder = "Task name"
        return textField
    }()
    
    private let taskNoteTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.borderStyle = .roundedRect
        textField.placeholder = "Task note"
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.animate()
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.animate()
        return button
    }()
    
    // MARK: - Properties
    
    var presenter: TaskEditorPresenterProtocol?
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private methods
    
    @objc private func saveButtonTapped() {
        presenter?.saveTask(name: taskNameTextField.text,
                            note: taskNoteTextField.text)
    }
    
    @objc private func cancelButtonTapped() {
        presenter?.didFinishEditing?(nil)
    }
    
    @objc private func animateButtonPush() {
        UIView.animate(withDuration: 0.15) {
            self.saveButton.transform = .init(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc private func animateButtonRelease() {
        UIView.animate(withDuration: 0.15) {
            self.saveButton.transform = .identity
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .white
    }
    
    private func configureTaskNameTextField() {
        taskNameTextField.delegate = self
        taskNoteTextField.delegate = self
        addHideKeyboardGesture()
    }
    
    private func layoutTaskNameTextField() {
        view.addSubview(taskNameTextField)
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Padding.regular),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Padding.regular),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Padding.regular)
        ])
    }
    
    private func layoutTaskNoteTextField() {
        view.addSubview(taskNoteTextField)
        taskNoteTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskNoteTextField.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: Padding.regular),
            taskNoteTextField.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            taskNoteTextField.trailingAnchor.constraint(equalTo: taskNameTextField.trailingAnchor),
            taskNameTextField.heightAnchor.constraint(equalTo: taskNameTextField.heightAnchor)
        ])
    }
    
    private func layoutSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: ButtonSize.height),
            saveButton.leadingAnchor.constraint(equalTo: taskNameTextField.leadingAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Padding.regular)
        ])
    }
    
    private func layoutCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: Padding.regular),
            cancelButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor),
            cancelButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: taskNameTextField.trailingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        configureTaskNameTextField()
        configureViewController()
        
        layoutTaskNameTextField()
        layoutTaskNoteTextField()
        layoutSaveButton()
        layoutCancelButton()
    }
    
    // MARK: - TaskEditorViewControllerProtocol methods
    
    func setTaskToEdit(taskName: String?, taskNote: String?) {
            taskNameTextField.text = taskName
            taskNoteTextField.text = taskNote
    }
}

// MARK: - UITextFieldDelegate

extension TaskEditorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == taskNameTextField {
            return updatedText.count <= MaxTextLenght.taskName
        } else {
            return updatedText.count <= MaxTextLenght.taskNote
        }
    }
}
