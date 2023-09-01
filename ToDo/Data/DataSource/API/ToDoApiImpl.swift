//
//  ToDoApiImpl.swift
//  ToDo
//
//  Created by Ali on 2022/12/11.
//

import Foundation

class ToDoApiImpl: ToDoDataSource{
    
    private let baseUrl: String = "https://jsonplaceholder.typicode.com/"
    let decoder = JSONDecoder()
    
    func add(_ todo: ToDoData) async throws {
        print("")
    }
    
    func delete(_ id: String) async throws {
        print("")
    }
    
    func edit(_ todo: ToDoData) async throws {
        print("")
    }
    
    func get(_ id: String) async throws -> ToDoData {
        return ToDoData(id: "13", title: "2", detail: "31", isCompleted: false, isSelectable: true)
    }
    
    func getList() async throws -> [ToDoData] {
        
        guard let url = URL(string: baseUrl + "todos") else { throw APIServiceError.badUrl }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url)else{
            throw APIServiceError.requestError
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{ throw APIServiceError.statusNotOK }
        
        guard let result = try? decoder.decode([JsonApiEntity].self, from: data) else { throw APIServiceError.decodingError }
        
        return result.map { entity in
            ToDoData(
                id: String(entity.id),
                title: entity.title,
                detail: entity.title,
                isCompleted: entity.completed,
                isSelectable: true
            )
        }
    }
}


enum APIServiceError: Error{
    case badUrl, requestError, decodingError, statusNotOK
}
