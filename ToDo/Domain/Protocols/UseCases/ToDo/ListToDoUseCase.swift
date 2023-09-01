//
//  ListToDoUseCase.swift
//  ToDo
//
//  Created by Ali on 2022/12/13.
//

import Foundation


protocol ListToDoUseCase{
    func execute() async throws -> [ToDoData]
}
