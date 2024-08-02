//
//  RectangleViewController.swift
//  Shapes
//
//  Created by Aref on 8/2/24.
//
import UIKit

class RectangleViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    /// Array to hold shapes
    var shapes: [Rectangle] = []
    
    // MARK: - UI Elements
    /// Stack view to organize UI elements
    private let stackView = UIStackView()
    private let widthTextField = UITextField()
    private let heightTextField = UITextField()
    private let addButton = UIButton(type: .system)
    private let calculateButton = UIButton(type: .system)
    private let resultLabel = UILabel()
    private let messageLabel = UILabel()
    private let titleLabel = UILabel()
    
    // MARK: - NumberFormatter
    /// Formatter to format numbers with up to 2 decimal places
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    /// Setup the user interface elements
    private func setupUI() {
        view.backgroundColor = .systemBlue
        setupTitleLabel()
        setupStackView()
        setupTextFields()
        setupButtons()
        setupLabels()
        setupConstraints()
    }
    
    /// Setup the title label
    private func setupTitleLabel() {
        titleLabel.text = "Rectangle Realm"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Measure the Magic of Shapes"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .white.withAlphaComponent(0.8)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    /// Setup the stack view
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
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
        stackView.addArrangedSubview(textField)
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
    
    /// Setup the labels
    private func setupLabels() {
        configureLabel(resultLabel)
        configureLabel(messageLabel, textColor: .red)
    }
    
    /// Configure a label with optional text color
    private func configureLabel(_ label: UILabel, textColor: UIColor = .black) {
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = textColor
        stackView.addArrangedSubview(label)
    }
    
    /// Setup the constraints for stack view
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Button Configuration
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
    
    // MARK: - Actions
    /// Add a new shape to the shapes array
    @objc private func addShape() {
        guard let width = Double(widthTextField.text ?? ""),
              let height = Double(heightTextField.text ?? ""),
              width > 0, height > 0 else {
            showMessage(.invalidInput)
            return
        }
        
        let rectangle = Rectangle(width: width, height: height)
        shapes.append(rectangle)
        
        clearInputFields()
        showMessage(.shapeAdded)
    }
    
    /// Calculate and display the total area and perimeter of all shapes
    @objc private func calculateResults() {
        guard !shapes.isEmpty else {
            showMessage(.noShapes)
            return
        }
        
        let totalArea = shapes.reduce(0) { $0 + $1.area() }
        let totalPerimeter = shapes.reduce(0) { $0 + $1.perimeter() }
        
        resultLabel.text = """
        Total Area: \(formatNumber(totalArea))
        Total Perimeter: \(formatNumber(totalPerimeter))
        """
    }
    
    // MARK: - Helper Methods
    /// Clear the input fields
    private func clearInputFields() {
        widthTextField.text = ""
        heightTextField.text = ""
    }

    /// Format a number to a string with up to 2 decimal places
    private func formatNumber(_ number: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }

    /// Show a message to the user
    private func showMessage(_ message: Message) {
        messageLabel.text = message.rawValue

        UIView.animate(withDuration: 0.3, animations: {
            self.messageLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2, options: [], animations: {
                self.messageLabel.alpha = 0
            }, completion: nil)
        }
    }
    // MARK: - UITextFieldDelegate
    /// Allow only decimal digits and periods in text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
}
// MARK: - Message Enum
extension RectangleViewController {
    enum Message: String {
        case invalidInput = "Please enter valid positive numbers for width and height."
        case shapeAdded = "Shape added successfully."
        case noShapes = "Please add shapes before calculating."
    }
}
#Preview{
    RectangleViewController()
}
