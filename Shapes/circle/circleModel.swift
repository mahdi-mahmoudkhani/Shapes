//
//  circleModel.swift
//  Shapes
//
//  Created by Mahsa on 7/30/24.
//

import Foundation

// Define a protocol for shapes that requires properties and methods related to shape calculations

protocol CircleShapeable{
    
    var radius : Double { get }
    
}

protocol CircleCalculable {
    
    func area() -> Double
    func perimeter() -> Double
   
    
}

protocol SphereCalculable {
    
    func volume() -> Double
    func sideArea() -> Double
    
}

class CircleModel : CircleShapeable , CircleCalculable , SphereCalculable {
    
    // Properties of the CircleModel
    private (set) var radius : Double
    private let pi = (Double( Double.pi * 100 )/100)
    
    
    init ( radius : Double ){
        self.radius = radius
    }
    
    
    func perimeter () -> Double {
        return self.radius * self.pi * 2
    }
    
    
    func area () -> Double {
        return pow(self.radius , 2.0) * self.pi
    }
    
    
    func volume() -> Double{
        return pow(self.radius , 3.0) * self.pi * 4/3
    }
    
    
    func sideArea() -> Double {
        return pow(self.radius , 2.0) * self.pi * 4
    }
    
    
    // Method to display all the calculated data
    func displayData(){
        print("Here was the Circle Data : Radius : \(self.radius)")
        
        print("The arae is : ")
        print(area())
        
        print("The perimeter is : ")
        print(perimeter())
        
        print("The volume of its sphere is : ")
        print(volume())
        
        print("The side area of its sphere is : ")
        print(sideArea())
        
        
    }
    
}
