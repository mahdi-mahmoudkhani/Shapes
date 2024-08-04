//
//  ShapesDetailVC.swift
//  Shapes
//
//  Created by Mahdi on 5/13/1403 AP.
//

import UIKit

class ShapesDetailVC: UIViewController {
    
    private (set) var squareInstances: [SquareModel] = []
    private (set) var calculatedData: [ [Double] ] = []
    private (set) var filterredData: [ [Double] ] = []
    private (set) var keyWord: String = ""
    
    @IBOutlet weak var sideSizeField: UITextField!
    @IBOutlet weak var sortOption: UISegmentedControl!
    @IBOutlet weak var resultFilter: UISegmentedControl!
    @IBOutlet weak var outputTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addNumberToArray(_ sender: UIButton) {
        
        guard let InteredText = self.sideSizeField.text, let InteredNum = Double(InteredText), InteredNum > 0 else {
            self.showInvalidInputAlert()
            
            return
        }
        self.squareInstances.append(SquareModel(side: InteredNum))
        self.sideSizeField.text = ""
    }
    
    
    @IBAction func calculateAreaButton(_ sender: Any) {
        
        self.keyWord = "Area"
        if self.squareInstances.isEmpty {
            self.showEmptyArrayAlert()
            
            return
        }
        self.calculateArea()
    }
    
    
    @IBAction func calculatePerimeterButton(_ sender: Any) {
        
        self.keyWord = "Perimeter"
        if squareInstances.isEmpty {
            self.showEmptyArrayAlert()
            
            return
        }
        self.calculatePerimiter()
    }
    
    @IBAction func sortSelected(_ sender: Any) {
        
        self.sortSelection()
    }
    
    @IBAction func numsFilterSelected(_ sender: Any) {
        
        self.filterResult()
    }
    
    @IBAction func clearResultButton(_ sender: Any) {
        
        self.showClearationAlert()
    }
    
    
    private func calculateArea() {
        
        self.calculatedData = []
        for instance in self.squareInstances {
            self.calculatedData.append([instance.side, instance.area()])
        }
        
        self.filterResult()
        self.sortSelection()
    }
    

    private func calculatePerimiter() {
        
        self.calculatedData = []
        for instance in self.squareInstances {
            self.calculatedData.append([instance.side, instance.perimeter()])
        }
        
        self.filterResult()
        self.sortSelection()
    }
    
    
    private func sortSelection() {
        
        if self.filterredData.isEmpty {
            self.filterredData = self.calculatedData
        }
        
        switch self.sortOption.selectedSegmentIndex {
        case 0 :
            self.filterredData.sort{ $0[1] < $1[1] }
            
        case 1 :
            self.filterredData.sort{ $0[1] > $1[1] }
            
        default:
            self.filterredData = self.calculatedData
        }
        
        self.createOutputText()
    }
    
    
    private func filterResult() {
        
        if self.filterredData.isEmpty {
            self.filterredData = self.calculatedData
        }
        
        switch self.resultFilter.selectedSegmentIndex {
        case 0:
            self.filterredData = self.calculatedData.filter( { $0[1].truncatingRemainder(dividingBy: 2) == 0 } )
        
        case 1:
            self.filterredData = self.calculatedData.filter( { $0[1].truncatingRemainder(dividingBy: 2) == 1 } )
            
        default:
            self.filterredData = self.calculatedData
        }
        
        self.createOutputText()
    }
    
    private func createOutputText() {
        
        var output: String = ""
        
        switch keyWord {
        case "Area":
            
            output = ""
            for (index, instance) in self.filterredData.enumerated() {
                output += "\(index + 1)th square is : \(instance[0]) ^ 2 = \(instance[1])\n"
            }
            
            if output.isEmpty && !self.calculatedData.isEmpty {
                output = "No valid square based on filters!\n"
            } else {
                output = "Square area formula is: side-size ^ 2\nArea of:\n" + output
            }
            
        case "Perimeter":

            output = ""
            for (index, instance) in self.filterredData.enumerated() {
                output += "\(index + 1)th square is : \(instance[0]) * 4 = \(instance[1])\n"
            }
            
            if output.isEmpty && !self.calculatedData.isEmpty {
                output = "No valid square based on filters!\n"
            } else {
                output = "Square perimeter formula is : side-size * 4\nPerimeter of:\n" + output
            }
            
        default:
            output = "Result will be shown here:\n"
        }
        
        self.outputTextView.text = output
    }
    
    private func handleClear() {
        
        self.outputTextView.text = "Result will be shown here:"
        self.squareInstances.removeAll()
        self.sideSizeField.text = ""
        self.calculatedData.removeAll()
        self.filterredData.removeAll()
        self.resultFilter.selectedSegmentIndex = 2
        self.sortOption.selectedSegmentIndex = 2
        self.keyWord = ""
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
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure to clear all data?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Clear", style: .default, handler: {_ in
            self.handleClear()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
