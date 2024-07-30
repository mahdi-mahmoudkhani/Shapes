//
//  circleModel.swift
//  Shapes
//
//  Created by Mahsa on 7/30/24.
//

import Foundation

class CircleModel{
    
    private (set) var radius : Double
    private let pi = (Double( Double.pi * 1000 )/1000)
    
    init ( radius : Double ){
            self.radius = radius
        }
    
    func perimeter () -> Double {
            return self.radius * self.pi * 2
        }
    
        
}
