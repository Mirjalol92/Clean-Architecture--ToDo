//
//  UseCaseContainer.swift
//  ToDo
//
//  Created by Ali on 2022/12/15.
//

import Foundation


extension AppDIContainer{
    struct UseCaseHolder {
        let addToDoUseCase = AddToDoUseCaseImpl(toDoRepository: ToDoRepositoryImpl(toDoDataSource: ToDoDBImpl(with: AppDIContainer.getInstance().context)))
        let deleteToDoUseCase = DeleteToDoUseCaseImpl(toDoRepository: ToDoRepositoryImpl(toDoDataSource: ToDoDBImpl(with: AppDIContainer.getInstance().context)))
        let editToDoUseCase = EditToDoUseCaseImpl(toDoRepository: ToDoRepositoryImpl(toDoDataSource: ToDoDBImpl(with: AppDIContainer.getInstance().context)))
        let getToDoUseCase = GetToDoUseCaseImpl(toDoRepository: ToDoRepositoryImpl(toDoDataSource: ToDoDBImpl(with: AppDIContainer.getInstance().context)))
        
        let listToDoUseCase = ListToDoUseCaseImpl(toDoRepository: ToDoRepositoryImpl(toDoDataSource: ToDoDBImpl(with: AppDIContainer.getInstance().context)))
        
        let listFromApiToDoUseCase = ListToDoUseCaseImpl(toDoRepository: ToDoRepositoryImpl(toDoDataSource: ToDoApiImpl()))
    }
}
