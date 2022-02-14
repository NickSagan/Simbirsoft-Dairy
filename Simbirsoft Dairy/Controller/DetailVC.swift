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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDetailView()
        displayEvent()
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
        detailView.start.text = event.dateInterval.start.dateString()
        detailView.finish.text = event.dateInterval.end.dateString()
        detailView.descriptionText.text = event.description
    }
}
