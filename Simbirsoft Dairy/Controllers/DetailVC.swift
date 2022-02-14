//
//  DetailVC.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 14.02.2022.
//

import UIKit

class DetailVC: UIViewController {
    
    var detailView: DetailView!
    var event: EventModel!
    private var ac: UIActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addDetailView()
        displayEvent()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(performActivity))
    }
    
    func addDetailView() {
        detailView = DetailView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func displayEvent() {
        detailView.name.text = event.text
        detailView.start.text = "Start: \(event.dateInterval.start.dateString())"
        detailView.finish.text = "Finish: \(event.dateInterval.end.dateString())"
        detailView.descriptionText.text = event.description
    }
    
    // Share your task with friends
    @objc private func performActivity() {
        let text = "Task: \(event.text)\nDescription: \(event.description)\nStart date: \(event.dateInterval.start.dateString())\nFinish date: \(event.dateInterval.end.dateString())"
        ac = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        ac.excludedActivityTypes = [.airDrop, .addToReadingList, .openInIBooks, .saveToCameraRoll]
        present(ac, animated: true)
    }
}
