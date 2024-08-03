//
//  ShapesDetailVC.swift
//  Shapes
//
//  Created by Mahdi on 5/13/1403 AP.
//

import UIKit

class ShapesDetailVC: UIViewController {
    
    @IBOutlet weak var sideSizeField: UITextField!
    
    private (set) var squareInstances: [SquareModel] = []
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var SortOption: UISegmentedControl!
    @IBOutlet weak var ResultFilter: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddNumberToArray(_ sender: UIButton) {
            guard let InteredText = sideSizeField.text, let InteredNum = Double(InteredText) else {
                ShowInvalidInputAlert()
                return
            }
            squareInstances.append(SquareModel(side: InteredNum))
            sideSizeField.text = ""
        }
    
    @IBAction func CalculateAreaButton(_ sender: Any) {
            SortSelection()
            if squareInstances.isEmpty {
                ShowEmptyArrayAlert()
                return
            }
            CalculateArea()
        }
        
    @IBAction func CleatResultButton(_ sender: Any) {
        ShowClearationAlert()
    }
    
    private func SortSelection() {
        switch SortOption.selectedSegmentIndex {
        case 0 :
            squareInstances.sort{ $0.side < $1.side }
        case 1 :
            squareInstances.sort{ $0.side > $1.side }
        default:
            ()
        }
    }
    
    private func ShowInvalidInputAlert() {
        let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid side size.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func CalculatePerimeterButton(_ sender: Any) {
            SortSelection()
            if squareInstances.isEmpty {
                ShowEmptyArrayAlert()
                return
            }
            CalculatePerimiter()
        }
    
    private func ShowEmptyArrayAlert() {
            let alert = UIAlertController(title: "Not Any Square", message: "Please enter one side size at least.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    private func CalculateArea() {
        
            var calculateResult: [[Double]] = []
        
            for instance in squareInstances {
                calculateResult.append([instance.side, instance.area()])
                squareInstances.removeFirst()
            }
            calculateResult = filterResult(givenResult: calculateResult)
        
            var output: String = "\n"
            for (index, instance) in calculateResult.enumerated() {
                output += "\nArea of the \(index + 1)th square is : \(instance[0]) ^ 2 = \(instance[1])"
            }
            outputTextView.text += output
        }
        
    private func CalculatePerimiter() {
        
            var calculateResult: [[Double]] = []
        
            for instance in squareInstances {
                calculateResult.append([instance.side, instance.perimeter()])
                squareInstances.removeFirst()
            }
            calculateResult = filterResult(givenResult: calculateResult)
        
            var output: String = "\n"
            for (index, instance) in calculateResult.enumerated() {
                output += "\nPerimeter of the \(index + 1)th square is : \(instance[0]) * 4 = \(instance[1])"
            }
            outputTextView.text += output
        }
    
    private func filterResult(givenResult: [[Double]]) -> [[Double]] {
        
        let filterredResult: [[Double]]
        
        switch ResultFilter.selectedSegmentIndex {
            
        case 0:
            filterredResult = givenResult.filter( { $0[1].truncatingRemainder(dividingBy: 2) == 0 } )
            
        case 1:
            filterredResult = givenResult.filter( { $0[1].truncatingRemainder(dividingBy: 2) == 1 } )
            
        default:
            filterredResult = givenResult
        }
        
        return filterredResult
    }
    
    private func ShowClearationAlert() {
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure to clear the result?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Clear", style: .default, handler: {_ in
            self.handleClear()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func handleClear() {
        outputTextView.text = "Result will be seen here:"
    }
    
}
