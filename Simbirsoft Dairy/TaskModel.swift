//
//  TaskModel.swift
//  Simbirsoft Dairy
//
//  Created by Nick Sagan on 13.02.2022.
//

import Foundation

struct TaskModel: Codable {
    let id: Int
    let date_start: TimeInterval
    let date_finish: TimeInterval
    let name: String
    let description: String
}
