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
        print("tap: \(String(describing: eventView.descriptor?.text) )")
        guard let eventModel = eventView.descriptor as? EventModel else { return }
        print(eventModel.description)

    }

    // Открываем экран подробного описания дела
    private func presentDetailViewForEvent(_ event: EventModel) {
//        let dvc = DetailVC()
//        dvc.event = event
//        navigationController?.pushViewController(dvc, animated: true)
    }
}
