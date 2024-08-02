//
//  RectangleViewController.swift
//  Shapes
//
//  Created by Aref on 8/2/24.
//

import UIKit

class RectangleViewController: UIViewController ,UITextFieldDelegate {
    
    // MARK: - Properties
    ///  Array to hold rectangles
    var rectangles: [Rectangle] = []
    
    // MARK: - UI Elements
    
    private let stacckView = UIStackView()
    private let widthTextField = UITextField()
    private let heightTextField = UITextField()
    private let addButton = UIButton()
    private let calculateButton = UIButton()
    private let resultLabel = UILabel()
    private let messageLabel = UILabel()
    private let titleLabel = UILabel()
    private let rectangleOutlineView: UIView = {
           let view = UIView()
           view.layer.borderColor = UIColor.white.cgColor
           view.layer.borderWidth = 2
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
       private let widthLabel: UILabel = {
           let label = UILabel()
           label.textColor = .white
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       private let heightLabel: UILabel = {
           let label = UILabel()
           label.textColor = .white
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    // MARK: - NumberFormatter
        /// Formatter to format numbers with up to 2 decimal places
        private let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            return formatter
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}
