//
//  ToDoUserDefaultImpl.swift
//  ToDo
//
//  Created by Ali on 2022/12/18.
//

import Foundation


class ToDoUserDefaultImpl: ToDoDataSource{
    
    @UserDefault(key: "todolist", defaultValue: [ToDoData]())
    private var toDoList: [ToDoData]
    
    func add(_ todo: ToDoData) async throws {
        var list = toDoList
        list.append(todo)
        self.toDoList = list
    }
    
    func delete(_ id: String) async throws {
        var list = toDoList
        guard let firstIndex = list.firstIndex(where: {$0.id == id}) else { throw EntityError.NotFound }
        list.remove(at: firstIndex)
        self.toDoList = list
    }
    
    func edit(_ todo: ToDoData) async throws {
        var list = toDoList
        if let firstIndex = list.firstIndex(where: {$0.id == todo.id}){
            list[firstIndex] = todo
        }
        self.toDoList = list
    }
    
    func get(_ id: String) async throws -> ToDoData {
        if let item = toDoList.first(where: {$0.id == id}){
            return item
        }else{
            throw EntityError.NotFound
        }
    }
    
    func getList() async throws -> [ToDoData] {
        return toDoList
    }
}
