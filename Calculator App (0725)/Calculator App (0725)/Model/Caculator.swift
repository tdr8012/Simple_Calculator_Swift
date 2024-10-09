//
//  Caculator.swift
//  Calculator App (0725)
//
//  Created by english on 2024-09-26.
//

import Foundation
import SwiftUI // for color

enum Keys: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
            
            
    //operation
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "÷"
    case equal = "="
    case clear = "AC"
    case negative = "-/+"
    case percent = "%"
    case decimal = "."
    
    var buttonColor: Color {
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
            return Color.voperator
        case .clear, .negative, .percent:
            return Color.hoperator
        default:
            return Color.num
            
        }
    }
    
    
}

//for operations
enum Operation{
    case add, multiply, subtract, divide, none
}
