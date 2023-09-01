//
//  AddViewViewModel.swift
//  ToDo
//
//  Created by Ali on 2022/11/18.
//

import Foundation

class EditViewModel{
    
    var addToDoUseCase: AddToDoUseCase
    var editToDoUseCase: EditToDoUseCase
    var deleteToDoUseCase: DeleteToDoUseCase
    
    init(
        addToDoUseCase: AddToDoUseCase,
        editToDoUseCase: EditToDoUseCase,
        deleteToDoUseCase: DeleteToDoUseCase
    ){
        self.addToDoUseCase = addToDoUseCase
        self.editToDoUseCase = editToDoUseCase
        self.deleteToDoUseCase = deleteToDoUseCase
    }
    
    private var isDeleting = false
    private var comingData: ToDoData? = nil
    
    func updateIsDeleting(value: Bool){
        isDeleting = value
    }
    
    func setToDoData(_ data: ToDoData?){
        comingData = data
    }
    
    func manageToDoData(title: String, detail: String){
        if let data = comingData{
            if isDeleting{
                deleteToDo(id: data.id)
            }else{
                editToDo(
                    data:ToDoData(
                        id: data.id,
                        title: title,
                        detail: detail,
                        isCompleted: data.isCompleted,
                        isSelectable: data.isSelectable
                    )
                )
            }
        }else{
            addToDo(data: ToDoData(id: UUID().uuidString, title: title, detail: detail,isCompleted: false, isSelectable: false))
        }
    }
    
    private func addToDo(data: ToDoData){
        Task{
            do{
                try await addToDoUseCase.execute(data)
            }catch{
                print("Error on Adding")
            }
        }
    }
    
    private func editToDo(data: ToDoData){
        Task{
            do{
                try await editToDoUseCase.execute(data)
            }catch{
                print("Error on Editing")
            }
        }
        
    }
    
    private func deleteToDo(id: String){
        Task{
            do{
                try await deleteToDoUseCase.execute(id)
            }catch{
                print("Error on Deleting")
            }
        }
    }
}
