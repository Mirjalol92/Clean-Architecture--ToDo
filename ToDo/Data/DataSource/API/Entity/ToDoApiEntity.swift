//
//  ToDoApiEntity.swift
//  ToDo
//
//  Created by Ali on 2022/12/12.
//

import Foundation

struct ToDoApiEntity: Codable{
    let id: String
    let title: String
    let detail: String
    var isCompleted: Bool
    let isSelectable: Bool
}

//https://jsonplaceholder.typicode.com/todos
struct JsonApiEntity: Decodable{
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
