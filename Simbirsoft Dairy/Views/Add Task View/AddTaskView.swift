//
//  AddTaskView.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 14.02.2022.
//

import UIKit

class AddTaskView: UIView {
    
//MARK: - VIEWS
    
    var taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "nameLabel"
        return label
    }()
    
    var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var startLabel: UILabel = {
        let label = UILabel()
        label.text = "Start date:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var finishLabel: UILabel = {
        let label = UILabel()
        label.text = "Finish date:"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nameTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = " Task name"
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 1.0
        txt.layer.cornerRadius = 5.0
        txt.accessibilityIdentifier = "inputName"
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    var descriptionTextField: UITextView = {
        let txt = UITextView()
        txt.layer.borderColor = UIColor.gray.cgColor
        txt.layer.borderWidth = 1.0
        txt.layer.cornerRadius = 5.0
        txt.sizeToFit()
        txt.accessibilityIdentifier = "inputDescription"
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    var startDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    var finishDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    var addTaskButton: UIButton = {
        let btn = UIButton(type: .system)
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            btn.configuration = config
        } else { }
        btn.setTitle("Add task", for: .normal)
        btn.accessibilityIdentifier = "addTask"
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
  
    
//MARK: - INITIALIZATION
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
  
//MARK: - SETUP & CONSTRAINTS
    
    func setUp() {
        self.addSubview(taskNameLabel)
        self.addSubview(taskDescriptionLabel)
        self.addSubview(startLabel)
        self.addSubview(finishLabel)
        self.addSubview(nameTextField)
        self.addSubview(descriptionTextField)
        self.addSubview(addTaskButton)
        self.addSubview(startDatePicker)
        self.addSubview(finishDatePicker)

        let margin = self.layoutMarginsGuide
        
        let constraints: [NSLayoutConstraint] = [
            taskNameLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            nameTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            taskDescriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            descriptionTextField.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            descriptionTextField.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            descriptionTextField.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.2),
            descriptionTextField.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            

            startLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 10),
            startLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            startDatePicker.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 10),
            startDatePicker.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            startDatePicker.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            finishLabel.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 10),
            finishLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            finishDatePicker.topAnchor.constraint(equalTo: finishLabel.bottomAnchor, constant: 10),
            finishDatePicker.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.1),
            finishDatePicker.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            addTaskButton.topAnchor.constraint(greaterThanOrEqualTo: finishDatePicker.bottomAnchor, constant: 20),
            addTaskButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: 50),
            addTaskButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -50),
            addTaskButton.bottomAnchor.constraint(lessThanOrEqualTo: margin.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
