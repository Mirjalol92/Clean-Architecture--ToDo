//
//  UserDefaultExts.swift
//  ToDo
//
//  Created by Ali on 2022/12/18.
//

import Foundation


@propertyWrapper
struct UserDefault<T>{
    let key: String
    let defaultValue: T
    var container: UserDefaults = .standard
    
    var wrappedValue: T{
        get{
            return container.object(forKey: key) as? T ?? defaultValue
        }
        set{
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults{
    @UserDefault<Bool>(key: "bool_key", defaultValue: false)
    static var testValue: Bool
}
