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
    
    // MARK: - UI Setup
       /// Setup the user interface elements
        private func setupUI() {
        
    }
    
    /// Setup the title label
    private func setupTitleLabel() {
        titleLabel.text = "Rectangle"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight:.bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Measure the Magic of Shapes"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = .white
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    /// Setup the stack view
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
    }
    
    /// Setup the text fields
    private func setupTextFields() {
        configureTextField(widthTextField, placeholder: "Width")
        configureTextField(heightTextField, placeholder: "Height")
    }
    
    /// Configure a text field with placeholder text
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.delegate = self
       
    }
    /// Setup the buttons
    private func setupButtons() {
        configureButton(addButton, title: "Add", action: #selector(addShape))
        configureButton(calculateButton, title: "Calculate", action: #selector(calculateResults))
    }

    /// Configure a button with title and action
    private func configureButton(_ button: UIButton, title: String, action: Selector) {
        button.configuration = createButtonConfiguration(title: title)
        button.addTarget(self, action: action, for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }

    /// Create a configuration for a button
    private func createButtonConfiguration(title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        config.cornerStyle = .medium
        return config
    }
    /// Setup the constraints for stack view
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: rectangleOutlineView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    
}
