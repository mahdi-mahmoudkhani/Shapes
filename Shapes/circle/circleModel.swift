//
//  circleModel.swift
//  Shapes
//
//  Created by Mahsa on 7/30/24.
//

import Foundation
protocol Shape{
    
    var radius : Double { get }
    var pi : Double { get }
    
    func perimeter () -> Double
    func area () -> Double
    func volume() -> Double
    func sideArea() -> Double
    func displayData()
    
}

class CircleModel : Shape{
    
    private (set) var radius : Double
    let pi = (Double( Double.pi * 1000 )/1000)
    
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
        
        print("The pi we took is : ")
        print(self.pi)
        
        
    }
    
    
}
