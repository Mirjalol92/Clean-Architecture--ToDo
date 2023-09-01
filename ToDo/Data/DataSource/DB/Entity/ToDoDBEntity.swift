//
//  ToDoDBEntity.swift
//  ToDo
//
//  Created by Ali on 2022/12/13.
//

import Foundation
import CoreData

extension ToDoDBEntity{
    
    //MARK: - requests
    static func findEntityRequest(by id: String) -> NSFetchRequest<ToDoDBEntity>{
        let request: NSFetchRequest<ToDoDBEntity> = ToDoDBEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        return request
    }
    
    static func fetchAllEntityRequest() -> NSFetchRequest<ToDoDBEntity>{
        return self.fetchRequest()
    }
    
    //MARK: - functins
    func editEntity(_ todo: ToDoData){
        self.title = todo.title
        self.detail = todo.detail
        self.isCompleted = todo.isCompleted
        self.isSelected = todo.isSelectable
    }
    
    func addEntity(_ todo: ToDoData){
        self.id = todo.id
        self.title = todo.title
        self.detail = todo.detail
        self.isCompleted = todo.isCompleted
        self.isSelected = todo.isSelectable
    }
    
    func encodeToData()->ToDoData{
        return ToDoData(id: id!, title: title!, detail: detail!, isCompleted: isCompleted, isSelectable: isSelected)
    }
}
