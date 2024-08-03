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
        
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
    }
    
    @IBAction func oddButtonTapped(_ sender: Any) {
    }
    
    @IBAction func evenButtonTapped(_ sender: Any) {
    }
    
    @IBAction func increasingSortTapped(_ sender: Any) {
    }
    
    @IBAction func decreasingSortTapped(_ sender: Any) {
    }
    
    
}

