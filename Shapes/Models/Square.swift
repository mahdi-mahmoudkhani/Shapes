//
//  Square.swift
//  Shapes
//
//  Created by Mahdi on 5/9/1403 AP.
//

import Foundation

protocol Shape {
    var side: Double { get }
    func perimeter() -> Double
    func area() -> Double
}

struct SquareModel: Shape {
    
    let side: Double
    
    func perimeter() -> Double {
        return side * 4
        }
    
    func area() -> Double {
        return pow(self.side, 2)
    }
    
}
