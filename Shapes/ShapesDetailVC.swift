//
//  ShapesDetailVC.swift
//  Shapes
//
//  Created by Mahdi on 5/13/1403 AP.
//

import UIKit

class ShapesDetailVC: UIViewController {
    
    private (set) var squareInstances: [SquareModel] = []
    
    @IBOutlet weak var sideSizeField: UITextField!
    @IBOutlet weak var sortOption: UISegmentedControl!
    @IBOutlet weak var resultFilter: UISegmentedControl!
    @IBOutlet weak var outputTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addNumberToArray(_ sender: UIButton) {
        
        guard let InteredText = self.sideSizeField.text, let InteredNum = Double(InteredText) else {
            self.showInvalidInputAlert()
            
            return
        }
        self.squareInstances.append(SquareModel(side: InteredNum))
        self.sideSizeField.text = ""
    }
    
    
    @IBAction func calculateAreaButton(_ sender: Any) {
        
        self.sortSelection()
        if self.squareInstances.isEmpty {
            self.showEmptyArrayAlert()
            
            return
        }
        self.calculateArea()
    }
    
    
    @IBAction func calculatePerimeterButton(_ sender: Any) {
        
        self.sortSelection()
        if squareInstances.isEmpty {
            self.showEmptyArrayAlert()
            
            return
        }
        self.calculatePerimiter()
    }
    
    
    @IBAction func clearResultButton(_ sender: Any) {
        
        self.showClearationAlert()
    }
    
    
    private func calculateArea() {
        
        var calculateResult: [[Double]] = []
        for instance in self.squareInstances {
            calculateResult.append([instance.side, instance.area()])
            self.squareInstances.removeFirst()
        }
        calculateResult = self.filterResult(givenResult: calculateResult)
        var output: String = "\n"
        for (index, instance) in calculateResult.enumerated() {
            output += "\nArea of the \(index + 1)th square is : \(instance[0]) ^ 2 = \(instance[1])"
        }
        self.outputTextView.text += output
    }
    

    private func calculatePerimiter() {
        
        var calculateResult: [[Double]] = []
        for instance in self.squareInstances {
            calculateResult.append([instance.side, instance.perimeter()])
            self.squareInstances.removeFirst()
        }
        calculateResult = self.filterResult(givenResult: calculateResult)
        var output: String = "\n"
        for (index, instance) in calculateResult.enumerated() {
            output += "\nPerimeter of the \(index + 1)th square is : \(instance[0]) * 4 = \(instance[1])"
        }
        self.outputTextView.text += output
    }
    
    
    private func sortSelection() {
        
        switch self.sortOption.selectedSegmentIndex {
        case 0 :
            self.squareInstances.sort{ $0.side < $1.side }
        case 1 :
            self.squareInstances.sort{ $0.side > $1.side }
        default:
            ()
        }
    }
    
    
    private func filterResult(givenResult: [[Double]]) -> [[Double]] {
        
        let filterredResult: [[Double]]
        switch self.resultFilter.selectedSegmentIndex {
        case 0:
            filterredResult = givenResult.filter( { $0[1].truncatingRemainder(dividingBy: 2) == 0 } )
        case 1:
            filterredResult = givenResult.filter( { $0[1].truncatingRemainder(dividingBy: 2) == 1 } )
        default:
            filterredResult = givenResult
        }
        
        return filterredResult
    }
    
    
    private func handleClear() {
        
        self.outputTextView.text = "Result will be shown here:"
    }
    
    
    private func showInvalidInputAlert() {
        
        let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid side size.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showEmptyArrayAlert() {
        
        let alert = UIAlertController(title: "Not Any Square", message: "Please enter one side size at least.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showClearationAlert() {
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure to clear the result?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Clear", style: .default, handler: {_ in
            self.handleClear()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
