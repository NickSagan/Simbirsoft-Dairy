//
//  ViewController.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 13.02.2022.
//

import UIKit
import CalendarKit // https://cocoapods.org/pods/CalendarKit

class CalendarVC: DayViewController {

    var tasks: [TaskModel] = [TaskModel(id: 1, date_start: 1644775438, date_finish: 1644776438, name: "Дело Номер 1", description: "Подробное описание дела номер 1"), TaskModel(id: 2, date_start: 1644851038, date_finish: 1644861038, name: "Дело Номер 2", description: "Подробное описание дела номер 2")]
    var events = [EventModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simbirsoft Dairy"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
    }
    
    @objc func addEvent() {
        let atvc = AddTaskVC()
        atvc.modalPresentationStyle = .pageSheet
        navigationController?.present(atvc, animated: true, completion: nil)
        
//        let event = EventModel()
//        event.id = 1
//        event.dateInterval = DateInterval(start: Date(timeIntervalSince1970: 1644851038), end: Date(timeIntervalSince1970: 1644869312))
//        event.text = "Дело 15"
//        event.description = "Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asap Very important task to do asapVery important task to do asap"
//        events.append(event)
//        print("Add event: \(event)")
//        reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        events = DataManager.shared.events
    }
    
    // Подгружаем список дел на заданный день
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        events
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
        dvc.modalPresentationStyle = .pageSheet
        navigationController?.present(dvc, animated: true, completion: nil)
    }
}
