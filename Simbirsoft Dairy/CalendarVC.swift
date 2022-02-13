//
//  ViewController.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 13.02.2022.
//

import UIKit
import CalendarKit
import EventKit
import EventKitUI

class CalendarVC: DayViewController {
    
    private let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simbirsoft"
        requestAccessToCalendar()
        subscribeToNotifications()
    }
    
    // Запрашиваем доступ к календарю пользователя, чтобы отображать список его дел
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: .event) { success, error in
            
        }
    }
    
    // Наблюдатель за изменениями в списке дел календаря пользователя
    func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(storeChanged(_:)), name: .EKEventStoreChanged, object: nil)
    }
    
    @objc func storeChanged(_ notification: Notification) {
        // Обновляем UI если появилось что-то новое в списке дел
        reloadData()
    }
    
    // Подгружаем список дел на заданный день из календаря
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        // формируем predicate на конкретную дату
        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1
        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        
        // Забираем весь список дел на указанную дату (predicate) из ИвентСтора
        let eventKitEvents = eventStore.events(matching: predicate)
        
        // Event Kit Events конвертируем в Calendar Kit Events
        let calendarKitEvents = eventKitEvents.map(EKWrapper.init)
        return calendarKitEvents
    }
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EKWrapper else { return }
        presentDetailViewForEvent(ckEvent.ekEvent)
    }
    
    private func presentDetailViewForEvent(_ ekEvent: EKEvent) {
        let detailVC = EKEventViewController()
        detailVC.event = ekEvent
        detailVC.allowsCalendarPreview = true
        detailVC.allowsEditing = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

