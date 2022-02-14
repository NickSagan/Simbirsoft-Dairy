//
//  DataManager.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 13.02.2022.
//

import Foundation

class DataManager {

    static let shared = DataManager()
    let adapter = Adapter()
    
    private init() { }
    
    // Simbirsoft JSON task files type
    private var tasks: [TaskModel] {
        get {
            guard let data = try? Data(contentsOf: .tasks) else { return [] }
            return (try? JSONDecoder().decode([TaskModel].self, from: data)) ?? []
        }
        set {
            try? JSONEncoder().encode(newValue).write(to: .tasks)
        }
    }
    
    // CalendarKit event type
    var events: [EventModel] {
        get {
            adapter.getEvents(from: tasks)
        }
        set {
            tasks = adapter.getTasks(from: newValue)
        }
    }
}

extension URL {
    static var tasks: URL {
        let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let bundleID = Bundle.main.bundleIdentifier ?? "NickSagan.Simbirsoft-Dairy"
        let subDirectory = applicationSupport.appendingPathComponent(bundleID, isDirectory: true)
        try? FileManager.default.createDirectory(at: subDirectory, withIntermediateDirectories: true, attributes: nil)
        return subDirectory.appendingPathComponent("tasks.json")
    }
}
