//
//  AddTaskVC.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 14.02.2022.
//

import UIKit

class AddTaskVC: UIViewController {
    
    var addTaskView: AddTaskView!
    var event: EventModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addView()
//        displayEvent()
    }
    
    func addView() {
        addTaskView = AddTaskView()
        addTaskView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTaskView)
        
        NSLayoutConstraint.activate([
            addTaskView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
//    func displayEvent() {
//        detailView.name.text = event.text
//        detailView.start.text = "Start: \(event.dateInterval.start.dateString())"
//        detailView.finish.text = "Finish: \(event.dateInterval.end.dateString())"
//        detailView.descriptionText.text = event.description
//    }
}
