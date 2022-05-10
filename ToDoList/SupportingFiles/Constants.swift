//
//  Constants.swift
//  ToDoListApp
//
//  Created by Владимир Паутов on 05.05.2022.
//

import UIKit

enum Padding {
    static var regular: CGFloat { 16 }
    static var compact: CGFloat { 8 }
}

enum ButtonSize {
    static var width: CGFloat { 150 }
    static var height: CGFloat { 50 }
}

enum LabelSize {
    static var maxHeight: CGFloat { 100 }
}

enum TextFieldSize {
    static var maxHeight: CGFloat { 100 }
}

enum MaxTextLenght {
    static var tasksListName: Int { 30 }
    
    static var taskName: Int { 50 }
    static var taskNote: Int { 100 }
}
