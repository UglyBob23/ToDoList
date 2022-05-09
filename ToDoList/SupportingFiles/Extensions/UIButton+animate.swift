//
//  UIButton+animate.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 06.05.2022.
//

import UIKit

extension UIButton {
    func animate() {
        self.addTarget(self, action: #selector(animateButtonPush), for: .touchDown)
        self.addTarget(self, action: #selector(animateButtonRelease), for: .touchUpInside)
        self.addTarget(self, action: #selector(animateButtonRelease), for: .touchUpOutside)
    }
    
    @objc func animateButtonPush() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc func animateButtonRelease() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
}
