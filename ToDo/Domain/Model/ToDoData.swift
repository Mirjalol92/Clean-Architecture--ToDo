//
//  DoToData.swift
//  ToDo
//
//  Created by Ali on 2022/11/13.
//

import Foundation


struct ToDoData: Codable{
    let id: String
    let title: String
    let detail: String
    var isCompleted: Bool
    let isSelectable: Bool
}
