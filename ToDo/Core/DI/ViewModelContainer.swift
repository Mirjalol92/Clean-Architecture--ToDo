//
//  ViewModelContainer.swift
//  ToDo
//
//  Created by Ali on 2022/12/14.
//

import Foundation

@propertyWrapper
struct InjetViewModel<T>{
    var wrappedValue: T?{
        get{
            switch T.self {
            case is MainViewModel.Type:
                return AppDIContainer.getInstance().viewModelHolder.mainViewModel as? T
            case is EditViewModel.Type:
                return AppDIContainer.getInstance().viewModelHolder.editViewModel as? T
            default:
                return nil
            }
        }
    }
}

extension AppDIContainer{
    struct ViewModelHolder{
        var mainViewModel: MainViewModel = MainViewModel(
            listToDouseCase:AppDIContainer.getInstance().useCaseHolder.listFromApiToDoUseCase,
            
            deleteToDoUseCase: AppDIContainer.getInstance().useCaseHolder.deleteToDoUseCase
        )
        
        var editViewModel: EditViewModel = EditViewModel(
            addToDoUseCase: AppDIContainer.getInstance().useCaseHolder.addToDoUseCase,
            editToDoUseCase: AppDIContainer.getInstance().useCaseHolder.editToDoUseCase,
            deleteToDoUseCase: AppDIContainer.getInstance().useCaseHolder.deleteToDoUseCase
        )
    }
}
