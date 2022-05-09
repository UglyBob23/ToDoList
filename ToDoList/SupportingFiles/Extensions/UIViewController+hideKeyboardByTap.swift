//
//  UIViewController+hideKeyboardByTap.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 18.02.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addHideKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
