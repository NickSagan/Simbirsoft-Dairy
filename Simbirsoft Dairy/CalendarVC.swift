//
//  ViewController.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 13.02.2022.
//

import UIKit
import CalendarKit
import EventKit

class CalendarVC: DayViewController {
    
    private let eventStore = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simbirsoft"
        requestAccessToCalendar()
    }
    
    // Запрашиваем доступ к календарю пользователя
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: .event) { success, error in
            
        }
    }
    
    // Подгружаем список дел на день из календаря
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1
        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let eventKitEvents = eventStore.events(matching: predicate)
        
        let calendarKitEvents = eventKitEvents.map { ekEvent -> Event in
            let ckEvent = Event()
            ckEvent.dateInterval = DateInterval(start: ekEvent.startDate, end: ekEvent.endDate)
            ckEvent.isAllDay = ekEvent.isAllDay
            ckEvent.text = ekEvent.title
            if let eventColor = ekEvent.calendar.cgColor {
                ckEvent.color = UIColor(cgColor: eventColor)
            }
            return ckEvent
        }
        return calendarKitEvents
    }

}

