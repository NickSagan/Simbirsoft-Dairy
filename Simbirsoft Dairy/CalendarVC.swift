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
        title = "Simbirsoft Dairy"
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
    
    // Обрабатываем нажатие на дело
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EKWrapper else { return }
        presentDetailViewForEvent(ckEvent.ekEvent)
    }
    
    // Открываем экран подробного описания дела
    private func presentDetailViewForEvent(_ ekEvent: EKEvent) {
        let detailVC = EKEventViewController()
        detailVC.event = ekEvent
        detailVC.allowsCalendarPreview = true
        detailVC.allowsEditing = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        // Отменяем редактирование текущего дела и начинаем создание нового
        endEventEditing()
        let newEKWrapper = createNewEvent(at: date)
        create(event: newEKWrapper, animated: true)
    }
    
    private func createNewEvent(at date: Date) -> EKWrapper {
        let newEKEvent = EKEvent(eventStore: eventStore)
        newEKEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        var components = DateComponents()
        components.hour = 1
        let endDate = calendar.date(byAdding: components, to: date)
        
        newEKEvent.startDate = date
        newEKEvent.endDate = endDate
        newEKEvent.title = "Новое дело"
        newEKEvent.notes = "Подробное описание дела"

        let newEKWrapper = EKWrapper(eventKitEvent: newEKEvent)
        newEKWrapper.editedEvent = newEKWrapper
        return newEKWrapper
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
           guard let descriptor = eventView.descriptor as? EKWrapper else {
               return
           }
           endEventEditing()
           beginEditing(event: descriptor,
                        animated: true)
       }
       
       override func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
           guard let editingEvent = event as? EKWrapper else { return }
           if let originalEvent = event.editedEvent {
               editingEvent.commitEditing()
               
               if originalEvent === editingEvent {
                   // If editing event is the same as the original one, it has just been created.
                   // Showing editing view controller
                   presentEditingViewForEvent(editingEvent.ekEvent)
               } else {
                   // If editing event is different from the original,
                   // then it's pointing to the event already in the `eventStore`
                   // Let's save changes to oriignal event to the `eventStore`
                   try! eventStore.save(editingEvent.ekEvent,
                                        span: .thisEvent)
               }
           }
           reloadData()
       }
       
       
       private func presentEditingViewForEvent(_ ekEvent: EKEvent) {
           let eventEditViewController = EKEventEditViewController()
           eventEditViewController.event = ekEvent
           eventEditViewController.eventStore = eventStore
           eventEditViewController.editViewDelegate = self
           present(eventEditViewController, animated: true, completion: nil)
       }
       
       override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
           endEventEditing()
       }
       
       override func dayViewDidBeginDragging(dayView: DayView) {
           endEventEditing()
       }
}

// MARK: - EKEventEditViewDelegate

extension CalendarVC: EKEventEditViewDelegate {
    
       func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
           endEventEditing()
           reloadData()
           controller.dismiss(animated: true, completion: nil)
       }
}

