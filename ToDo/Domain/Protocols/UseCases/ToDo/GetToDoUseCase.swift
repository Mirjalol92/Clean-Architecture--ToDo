//
//  GetToDoUseCase.swift
//  ToDo
//
//  Created by Ali on 2022/12/13.
//

import Foundation


protocol GetToDoUseCase{
    func execute(_ id: String) async throws -> ToDoData
}
