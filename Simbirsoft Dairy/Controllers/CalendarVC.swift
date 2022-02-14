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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        events = DataManager.shared.events
        for event in events {
            print(event.id, event.text)
        }
        reloadData()
    }
    
    @objc func addEvent() {
        let atvc = AddTaskVC()
        navigationController?.pushViewController(atvc, animated: true)
    }
    
    // Подгружаем список дел на заданный день
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return events
    }

    // Обрабатываем нажатие на дело
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let eventModel = eventView.descriptor as? EventModel else { return }
        presentDetailViewForEvent(eventModel)
    }

    // Открываем экран подробного описания дела
    private func presentDetailViewForEvent(_ event: EventModel) {
        let dvc = DetailVC()
        dvc.event = event
        navigationController?.pushViewController(dvc, animated: true)
    }
}
