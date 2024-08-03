//
//  ViewController.swift
//  CircleCalculator
//
//  Created by Mahsa on 8/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    var circleModel : [CircleModel] = []
    var segmentIndex : [Int] = []
    var results : [Double] = []
//    
//    var oddResults : [Double] = []
//    var evenResults : [Double] = []
//    var inSortedResults : [Double] = []
//    var deSortedResults : [Double] = []
//    
//    func isOdd ( input : Double ) -> Bool{
//        guard input % 2.0 == 0.0 else {
//            return true
//        }else
//            return true
//    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let text = textField.text, 
        let radius = Double(text) else {
            return
        }
        
        let circle = CircleModel(radius: radius)
                circleModel.append(circle)
                segmentIndex.append(segmentControl.selectedSegmentIndex)
                textField.text = ""
    }
    
    @IBAction func resetButoonTapped(_ sender: Any) {
        
        circleModel.removeAll()
        results.removeAll()
        segmentIndex.removeAll()
        
        textField.text=""
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        //after hitting calculate button we make results
        //if there was any remove it
        results.removeAll()
        
        for (index , circle  ) in circleModel.enumerated(){
            
            let segmentindec = segmentIndex[index]
           
            switch segmentindec {
            case 0 :
                
                results.append(circle.area())
                break
            case 1 :
                
                results.append(circle.perimeter())
                break
                
            case 2 :
                results.append(circle.volume())
                break
                
            case 3 :
                results.append(circle.sideArea())
                break
                
            default:
                break
            }
            
        }
        //needs a function to show resluts maybe
        
    }
    
    @IBAction func oddButtonTapped(_ sender: Any) {
        
        let oddResults = results.filter { Int($0)%2 != 0 }
        Show(oddResults)
    }
    
    @IBAction func evenButtonTapped(_ sender: Any) {
        
        let evenResults = results.filter { Int($0)%2 == 0 }
        Show(evenResults)
    }
    
    @IBAction func increasingSortTapped(_ sender: Any) {
        
        let inSortedResults = results.sorted()
        Show(inSortedResults)
    }
    
    @IBAction func decreasingSortTapped(_ sender: Any) {
        
        let deSortedResults = results.sorted(by: > )
        Show(deSortedResults)
    }
    
    func Show( _ results: [Double]){
        
       // print("Displaying results: \(results)")
        let resultText = results.map { "\($0)" }.joined(separator: "\n")
        
        resultTextView.text = resultText
    }
    
    
}

