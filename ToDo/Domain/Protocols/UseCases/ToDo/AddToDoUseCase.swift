//
//  CreateUseCaseProtocol.swift
//  ToDo
//
//  Created by Ali on 2022/12/10.
//

import Foundation


protocol AddToDoUseCase{
    func execute(_ todo: ToDoData) async throws
}


