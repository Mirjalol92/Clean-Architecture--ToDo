//
//  ToDoDBImpl.swift
//  ToDo
//
//  Created by Ali on 2022/12/13.
//

import Foundation
import CoreData
class ToDoDBImpl: ToDoDataSource{
    
    //MARK: - Properties
    var context: NSManagedObjectContext!
    
    init(with context: NSManagedObjectContext){
        self.context = context
    }
    
    func add(_ todo: ToDoData) async throws {
        let entity = ToDoDBEntity(context: context)
        entity.addEntity(todo)
        try saveContext()
    }
    
    func delete(_ id: String) async throws {
        switch find(by: id){
        case .success(let entity):
            context.delete(entity)
        case .failure(let error):
            throw error
        }
    }
    
    func edit(_ todo: ToDoData) async throws {
        switch find(by: todo.id){
        case .success(let entity):
            entity.editEntity(todo)
            try saveContext()
        case .failure(let error):
            throw error
        }
    }
    
    func get(_ id: String) async throws -> ToDoData {
        switch find(by: id){
        case .success(let entity):
            return ToDoData(
                    id: entity.id ?? "",
                    title: entity.title ?? "",
                    detail: entity.detail ?? "",
                    isCompleted: entity.isCompleted,
                    isSelectable: entity.isSelected
                )
        case .failure(let error):
            throw error
        }
    }
    
    func getList() async throws -> [ToDoData] {
        let request = ToDoDBEntity.fetchAllEntityRequest()
        do{
            let todoList = try context.fetch(request).map({ entity in
                entity.encodeToData()
            })
            return todoList
        }catch{
            throw EntityError.NotFound
        }
    }
    
    //MARK: - Private functions
    private func find(by id: String)->Result<ToDoDBEntity, EntityError>{
        let findEntity = ToDoDBEntity.findEntityRequest(by: id)
        do{
            if let entity = try context.fetch(findEntity).first{
                return Result.success(entity)
            }else{
                return Result.failure(EntityError.NotFound)
            }
            
        }catch{
            return Result.failure(EntityError.NotFound)
        }
    }
    
    private func saveContext() throws{
        if context.hasChanges{
            do {
                try context.save()
            }catch{
                throw EntityError.Error
            }
        }
    }
    
}

enum EntityError: Error{
    case NotFound
    case Error
}
