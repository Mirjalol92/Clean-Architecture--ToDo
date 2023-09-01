//
//  DeleteToDoUseCase.swift
//  ToDo
//
//  Created by Ali on 2022/12/13.
//

import Foundation


protocol DeleteToDoUseCase{
    func execute(_ id: String) async throws
}
