//
//  IDFabric.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 14.02.2022.
//

import Foundation

// ID Fabcric. Creates unique identifier for tasks/events
class IDFabric {

    static let shared = IDFabric()
    private var id: Int {
        get {
           UserDefaults.standard.integer(forKey: "uniqueID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "uniqueID")
        }
    }
    
    private let modificator: Int = 10000 // incomplete temporary logic to separate user generated task's ID and JSON task's ID, by adding 10000 to unique ID
    
    private init() { }
    
    public func getUniqueID() -> Int {
        id += 1
        return id + modificator
    }
}
