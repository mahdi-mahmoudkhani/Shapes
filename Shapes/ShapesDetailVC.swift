//
//  ShapesDetailVC.swift
//  Shapes
//
//  Created by Mahdi on 5/13/1403 AP.
//

import UIKit

class ShapesDetailVC: UIViewController {
    
    @IBOutlet weak var sideSizeField: UITextField!
    
    private (set) var sideSizes: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func AddNumberToArray(_ sender: UIButton) {
            guard let InteredText = sideSizeField.text, let InteredNum = Double(InteredText) else {
                ShowInvalidInputAlert()
                return
            }
            sideSizes.append(InteredNum)
            sideSizeField.text = ""
        }

    private func ShowInvalidInputAlert() {
        let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid side size.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
