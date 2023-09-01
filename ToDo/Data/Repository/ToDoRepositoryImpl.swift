//
//  ToDoRepositoryImpl.swift
//  ToDo
//
//  Created by Ali on 2022/12/11.
//

import Foundation
import UIKit

class ToDoRepositoryImpl: ToDoRepository{
    //MARK: - Properties
    var toDoDataSource: ToDoDataSource!
    
    init(toDoDataSource: ToDoDataSource){
        self.toDoDataSource = toDoDataSource
    }
    
    //MARK: - Functions
    func add(_ todo: ToDoData) async throws {
        try await toDoDataSource.add(todo)
    }
    
    func delete(_ id: String) async throws {
        try await toDoDataSource.delete(id)
    }
    
    func edit(_ todo: ToDoData) async throws {
        try await toDoDataSource.edit(todo)
    }
    
    func get(_ id: String) async throws -> ToDoData {
        return try await toDoDataSource.get(id)
    }
    
    func getList() async throws -> [ToDoData] {
        return try await toDoDataSource.getList()
    }
}
