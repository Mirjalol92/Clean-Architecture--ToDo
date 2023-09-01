//
//  ToDoDataSource.swift
//  ToDo
//
//  Created by Ali on 2022/12/11.
//

import Foundation

protocol ToDoDataSource{
    func add(_ todo: ToDoData) async throws
    func delete(_ id: String) async throws
    func edit(_ todo: ToDoData) async throws
    func get(_ id: String) async throws -> ToDoData
    func getList() async throws -> [ToDoData]
}
