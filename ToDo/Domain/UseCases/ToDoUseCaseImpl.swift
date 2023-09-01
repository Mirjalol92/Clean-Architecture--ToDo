//
//  ToDoUseCaseImpl.swift
//  ToDo
//
//  Created by Ali on 2022/12/11.
//

import Foundation
import UIKit


class AddToDoUseCaseImpl: AddToDoUseCase{
    var toDoRepository: ToDoRepository!
    init(toDoRepository: ToDoRepository){
        self.toDoRepository = toDoRepository
    }
    
    func execute(_ todo: ToDoData) async throws {
        try await toDoRepository.add(todo)
    }
}

class DeleteToDoUseCaseImpl: DeleteToDoUseCase{
    var toDoRepository: ToDoRepository!
    init(toDoRepository: ToDoRepository){
        self.toDoRepository = toDoRepository
    }
    
    func execute(_ id: String) async throws {
        try await toDoRepository.delete(id)
    }
}

class EditToDoUseCaseImpl: EditToDoUseCase{
    var toDoRepository: ToDoRepository!
    init(toDoRepository: ToDoRepository){
        self.toDoRepository = toDoRepository
    }
    
    func execute(_ todo: ToDoData) async throws {
        try await toDoRepository.edit(todo)
    }
    
}

class GetToDoUseCaseImpl: GetToDoUseCase{
    var toDoRepository: ToDoRepository!
    init(toDoRepository: ToDoRepository){
        self.toDoRepository = toDoRepository
    }
    
    func execute(_ id: String) async throws -> ToDoData {
        return try await toDoRepository.get(id)
    }
}

class ListToDoUseCaseImpl: ListToDoUseCase{
    var toDoRepository: ToDoRepository!
    init(toDoRepository: ToDoRepository){
        self.toDoRepository = toDoRepository
    }
    
    func execute() async throws -> [ToDoData] {
        return try await toDoRepository.getList()
    }
}
