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
    var detailedResults: [(radius: Double, function: String, result: Double)] = []
    
    
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
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let text = textField.text, !text.isEmpty, let radius = Double(text) , radius > 0 else {
            
                    // Show alert if input is invalid
                    showAlert(message: "Please enter a valid radius.")
                    return
            
                }
        
        let circle = CircleModel( radius: radius)
        
                circleModel.append(circle)
                segmentIndex.append(segmentControl.selectedSegmentIndex)
                textField.text = ""
        
    }
    
    @IBAction func resetButoonTapped(_ sender: Any) {
        
        circleModel.removeAll()
        detailedResults.removeAll()
        segmentIndex.removeAll()
        
        textField.text=""
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        //after hitting calculate button we make results
        //if there was any remove it
        detailedResults.removeAll()
        
        for (index , circle  ) in circleModel.enumerated(){
            
            let segmentindec = segmentIndex[index]
            let ans: Double
            let functionName: String
           
            switch segmentindec {
            case 0 :
                
                ans = circle.area()
                functionName = "Area"
                
                break
            case 1 :
                
                ans = circle.perimeter()
                functionName = "Perimeter"
                break
                
            case 2 :
                
                ans = circle.volume()
                functionName = "Volume"
                break
                
            case 3 :
                ans = circle.sideArea()
                functionName = "Side Area"
                break
                
            default:
                continue
            }
            
            detailedResults.append((radius: circle.radius, function: functionName, result : ans) )
        }
        
        //needs a function to show resluts maybe
        
    }
    
    
    @IBAction func oddButtonTapped(_ sender: Any) {
        
        let oddResults = detailedResults.filter { Int($0.result) % 2 != 0 }
        Show(oddResults)
    }
    
    
    @IBAction func evenButtonTapped(_ sender: Any) {
        
        let evenResults = detailedResults.filter { Int($0.result) % 2 == 0 }
        Show(evenResults)
    }
    
    
    @IBAction func increasingSortTapped(_ sender: Any) {
        
        let inSortedResults = detailedResults.sorted { $0.result < $1.result }
        Show(inSortedResults)
    }
    
    
    @IBAction func decreasingSortTapped(_ sender: Any) {
        
        let deSortedResults = detailedResults.sorted { $0.result > $1.result }
        Show(deSortedResults)
    }
    
    
    @IBAction func normalShowButton(_ sender: Any) {
        Show(detailedResults)
    }
    
    
    func Show( _ results: [(radius: Double, function: String, result: Double)]){
        
       // print("Displaying results: \(results)")
        
        
        let resultText = results.map {
        "Radius: \($0.radius), Function: \($0.function), Result: \($0.result)"
        }.joined(separator: "\n")
                
        resultTextView.text = resultText
      
    }
        
    
    func showAlert(message: String) {
           let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    
    
}

