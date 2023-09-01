//
//  MainViewModel.swift
//  ToDo
//
//  Created by Ali on 2022/11/14.
//

import Foundation

class MainViewModel{
    //MARK: - UseCases
    var listToDouseCase: ListToDoUseCase!
    var deleteToDoUseCase: DeleteToDoUseCase!
    
    init(
        listToDouseCase: ListToDoUseCase,
        deleteToDoUseCase: DeleteToDoUseCase
    ){
        self.listToDouseCase = listToDouseCase
        self.deleteToDoUseCase = deleteToDoUseCase
    }
    
    //MARK: - Variables
    var filteredText:String = ""
    var filterTimer: Timer? = nil
    private var editToDo:ToDoData? = nil
    private var deleteList: [String] = [String]()
    
    //MARK: - LiveDatas
    let toDoList: Dynamic<[ToDoData]> = Dynamic([ToDoData]())
    let leftBarItemState: Dynamic<Bool> = Dynamic(false)
    
    
    func setLeftBarItemState(isDone: Bool){
        leftBarItemState.value = isDone
        toDoList.value = toDoList.value.map { todo in
            return ToDoData(id: todo.id, title: todo.title, detail: todo.detail, isCompleted: todo.isCompleted, isSelectable: !isDone)
        }
    }

    func setEditToDo(_ data: ToDoData?){
        editToDo = data
    }
    
    func getEditToDo()->ToDoData?{
        return editToDo
    }
    
    func getToDoList(){
        Task{
            do{
                let result = try await listToDouseCase.execute()
                self.toDoList.value = result
            }catch{
                print(error)
                self.toDoList.value = [ToDoData]()
            }
            
        }
    }
    
    func getCountOfToDoList()->Int{
        return toDoList.value.count
    }
    
    func getToDoItem(index: Int)->ToDoData{
        return toDoList.value[index]
    }
    
    func delete(at index: Int){
        let list = self.toDoList.value
        let id = list[index].id
        Task{
            do{
                try await deleteToDoUseCase.execute(id)
            }catch{
                print("Error on delete an item")
            }
        }
    }
    
    func addToDeleteList(todo: ToDoData){
        let foundIndex = deleteList.firstIndex(where: {$0 == todo.id})
        if foundIndex == nil || todo.isCompleted == false{
            deleteList.append(todo.id)
        }else{
            deleteList.remove(at: foundIndex!)
        }
    }
    
    func deletedSelected(msg:(String)->()){
        if deleteList.isEmpty{
            msg("There is not selected items to delete")
        }else{
            for deleteId in deleteList{
                Task{
                    do{
                        try await deleteToDoUseCase.execute(deleteId)
                    }catch{
                        print("Error on delete an item")
                    }
                }
            }
            msg("Delete completed")
            getToDoList()
            setLeftBarItemState(isDone: !leftBarItemState.value)
        }
    }
    
    func filterToDoList(by text: String){
        if filteredText == text{
            return
        }else{
            filteredText = text
        }
        
        filterTimer?.invalidate()
        filterTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            print(text)
            if text.isEmpty{
                self.getToDoList()
            }else{
                Task{
                    do{
                        let result = try await self.listToDouseCase.execute()
                        self.toDoList.value = result.filter({ todo in
                            todo.title.lowercased().contains(text.lowercased())
                        })
                    }catch{
                        print(error)
                    }
                }
                
            }
        })
    }
    
    func todayInString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM dd"
        return formatter.string(from: Date())
    }
    
    
    deinit{
        toDoList.clearBind()
        leftBarItemState.clearBind()
    }
}
