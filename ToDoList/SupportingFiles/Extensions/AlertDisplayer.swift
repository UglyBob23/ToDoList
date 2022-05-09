//
//  AlertDisplayer.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 24.03.2022.
//

import UIKit

protocol AlertDisplayer {
    func showAlert(title: String, message: String)
}

extension AlertDisplayer where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
