//
//  Colors.swift
//  ToDoList
//
//  Created by Владимир Паутов on 12.05.2022.
//

import UIKit

enum Colors {
    enum Views {
        static var background: UIColor { UIColor(named: "background") ?? .systemGray }
    }
    
    enum Buttons {
        static var red: UIColor { UIColor(named: "buttonRed") ?? .systemRed }
        static var green: UIColor { UIColor(named: "buttonGreen") ?? .systemGreen }
        static var blue: UIColor { UIColor(named: "buttonBlue") ?? .systemBlue }
    }
    
    enum TextFields {
        static var background: UIColor { UIColor(named: "textField") ?? .white }
    }
}
