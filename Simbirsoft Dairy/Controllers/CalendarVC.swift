//
//  ViewController.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 13.02.2022.
//

import UIKit
import CalendarKit // https://cocoapods.org/pods/CalendarKit

class CalendarVC: DayViewController {

    var events = [EventModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simbirsoft Dairy"
        view.backgroundColor = .systemBackground
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        button.accessibilityIdentifier = "addButtonCalendarVC"
        navigationItem.rightBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check for updates
        events = DataManager.shared.events
        reloadData()
    }
    
    @objc func addEvent() {
        let atvc = AddTaskVC()
        navigationController?.pushViewController(atvc, animated: true)
    }
    
    // Upload events/tasks
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return events
    }

    // Handle event/task tap
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let eventModel = eventView.descriptor as? EventModel else { return }
        presentDetailViewForEvent(eventModel)
    }

    // Push detailed view controller
    private func presentDetailViewForEvent(_ event: EventModel) {
        let dvc = DetailVC()
        dvc.event = event
        navigationController?.pushViewController(dvc, animated: true)
    }
}
