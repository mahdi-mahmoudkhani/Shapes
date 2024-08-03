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
            if squareInstances.isEmpty {
                ShowEmptyArrayAlert()
                return
            }
            CalculateArea()
        }
        
    private func ShowInvalidInputAlert() {
        let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid side size.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func CalculatePerimeterButton(_ sender: Any) {
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
            var output: String = ""
            for (index, instance) in squareInstances.enumerated() {
                output += "Area of the \(index + 1)th square is : \(instance.side) ^ 2 = \(instance.area())\n"
                squareInstances.removeFirst()
            }
            outputTextView.text += output
        }
        
    private func CalculatePerimiter() {
            var output: String = ""
            for (index, instance) in squareInstances.enumerated() {
                output += "Perimeter of the \(index + 1)th square is : \(instance.side) * 4 = \(instance.perimeter())\n"
                squareInstances.removeFirst()
            }
            outputTextView.text += output
        }
    
}
