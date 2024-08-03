//
//  RectangleViewController.swift
//  Shapes
//
//  Created by Aref on 8/2/24.
//

import UIKit

class RectangleViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties

    var shapes: [Rectangle] = []
    var filteredShapes: [Rectangle] = []
    var storedDimensions: [(width: Double, height: Double)] = []  // New property to store dimensions

    // MARK: - UI Elements

    private let stackView = UIStackView()
    private let widthTextField = UITextField()
    private let heightTextField = UITextField()
    private let addButton = UIButton(type: .system)
    private let calculateButton = UIButton(type: .system)  // New calculate button
    private let clearButton = UIButton(type: .system)
    private let sortDescendingButton = UIButton(type: .system)
    private let sortAscendingButton = UIButton(type: .system)
    private let sortEvenButton = UIButton(type: .system)
    private let sortOddButton = UIButton(type: .system)
    private let resultLabel = UILabel()
    private let messageLabel = UILabel()
    private let titleLabel = UILabel()
    private var listView: UITableView?

    // MARK: - NumberFormatter
    // Formatter to format numbers with up to 2 decimal place
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
        setupListView()
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
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    /// Setup the stack view
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
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
        stackView.addArrangedSubview(textField)
    }
    /// Setup the buttons
    private func setupButtons() {
        configureButton(addButton, title: "Add", action: #selector(addDimensions))
        configureButton(calculateButton, title: "Calculate", action: #selector(calculateShapes))  // New calculate button
        configureButton(clearButton, title: "Clear", action: #selector(clearShapes))

        let sortStackView = UIStackView()
        sortStackView.axis = .horizontal
        sortStackView.spacing = 5
        sortStackView.distribution = .fillEqually
        sortStackView.translatesAutoresizingMaskIntoConstraints = false

        configureButton(sortDescendingButton, title: "Sort Desc", action: #selector(sortShapesDescending))
        configureButton(sortAscendingButton, title: "Sort Asc", action: #selector(sortShapesAscending))
        configureButton(sortEvenButton, title: "Show Even", action: #selector(showEvenShapes))
        configureButton(sortOddButton, title: "Show Odd", action: #selector(showOddShapes))

        sortStackView.addArrangedSubview(sortDescendingButton)
        sortStackView.addArrangedSubview(sortAscendingButton)
        sortStackView.addArrangedSubview(sortEvenButton)
        sortStackView.addArrangedSubview(sortOddButton)

        stackView.addArrangedSubview(sortStackView)
    }
    /// Configure a button with title and action
    private func configureButton(_ button: UIButton, title: String, action: Selector) {
        button.configuration = createButtonConfiguration(title: title)
        button.addTarget(self, action: action, for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }

    private func setupLabels() {
        configureLabel(resultLabel, textColor: .white)
        configureLabel(messageLabel, textColor: .yellow)

        resultLabel.textAlignment = .left
    }
    /// Setup the labels
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
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    /// Sets up and configures the UITableView with constraints, data source, and delegate
    private func setupListView() {
        listView = UITableView(frame: .zero, style: .plain)
        listView?.translatesAutoresizingMaskIntoConstraints = false
        if let listView = listView {
            view.addSubview(listView)

            NSLayoutConstraint.activate([
                listView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
                listView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                listView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            ])

            listView.dataSource = self
            listView.delegate = self
            listView.register(UITableViewCell.self, forCellReuseIdentifier: "RectangleCell")
        }
    }

    // MARK: - Button Configuration

    private func createButtonConfiguration(title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        config.cornerStyle = .medium

        return config
    }

    // MARK: - Actions

    /// This function adds the entered dimensions to the stored dimensions array
    @objc private func addDimensions() {
        guard let width = Double(widthTextField.text ?? ""),
              let height = Double(heightTextField.text ?? ""),
              width > 0, height > 0 else {
            showMessage(.invalidInput)
            return
        }

        storedDimensions.append((width: width, height: height))

        clearInputFields()
        showMessage(.dimensionsAdded)
    }

    /// This function calculates shapes from stored dimensions and adds them to the list view
    @objc private func calculateShapes() {
        guard !storedDimensions.isEmpty else {
            showMessage(.noDimensions)
            return
        }

        for dimension in storedDimensions {
            let rectangle = Rectangle(width: dimension.width, height: dimension.height)
            shapes.append(rectangle)
        }

        storedDimensions.removeAll()
        filteredShapes = shapes
        listView?.reloadData()
        showMessage(.shapesCalculated)
    }

    /// This function clears all shapes and refreshes the list view
    @objc private func clearShapes() {
        shapes.removeAll()
        filteredShapes.removeAll()
        storedDimensions.removeAll()
        listView?.reloadData()
        showMessage(.clearShape)
    }
    
    /// This function sorts the shapes in descending order by area and perimeter, then refreshes the list view
    @objc private func sortShapesDescending() {
        shapes.sort { ($0.area(), $0.perimeter()) > ($1.area(), $1.perimeter()) }
        filteredShapes = shapes
        listView?.reloadData()
    }

    /// This function sorts the shapes in ascending order by area and perimeter, then refreshes the list view
    @objc private func sortShapesAscending() {
        shapes.sort { ($0.area(), $0.perimeter()) < ($1.area(), $1.perimeter()) }
        filteredShapes = shapes
        listView?.reloadData()
    }

    /// This function filters the shapes to only show those with even area and perimeter, then refreshes the list view
    @objc private func showEvenShapes() {
        filteredShapes = shapes.filter { isEven($0.area()) && isEven($0.perimeter()) }
        listView?.reloadData()
    }

    /// This function filters the shapes to only show those with odd area and perimeter, then refreshes the list view
    @objc private func showOddShapes() {
        filteredShapes = shapes.filter { !isEven($0.area()) && !isEven($0.perimeter()) }
        listView?.reloadData()
    }

    // MARK: - Helper Methods

    private func clearInputFields() {
        widthTextField.text = ""
        heightTextField.text = ""
    }

    private func formatNumber(_ number: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }

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

    private func isEven(_ number: Double) -> Bool {
        return Int(number) % 2 == 0
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredShapes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RectangleCell", for: indexPath)
        let rectangle = filteredShapes[indexPath.row]
        cell.textLabel?.text = "\(rectangle.description())"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        cell.detailTextLabel?.textColor = .gray
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rectangle = filteredShapes[indexPath.row]
        let alert = UIAlertController(title: "Rectangle \(indexPath.row + 1)", message: rectangle.description(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Message Enum

extension RectangleViewController {
    enum Message: String {
        case invalidInput = "Please enter valid positive numbers for width and height."
        case dimensionsAdded = "Dimensions added successfully."
        case noDimensions = "Please add dimensions before calculating."
        case shapesCalculated = "Shapes calculated and added to the list."
        case clearShape = "All shapes and dimensions were successfully deleted."
    }
}

// MARK: - Preview

#Preview {
    RectangleViewController()
}
