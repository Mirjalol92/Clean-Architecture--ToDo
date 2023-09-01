//
//  EditToDoUseCase.swift
//  ToDo
//
//  Created by Ali on 2022/12/13.
//

import Foundation


protocol EditToDoUseCase{
    func execute(_ todo: ToDoData) async throws
}
