//
//  UserDefaultWrapper.swift
//  UserDefaults and Property Wrappers
//
//  Created by Bo on 6/5/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults = .standard
    
    var wrappedValue: T {
        get {
            // retrieve
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // delete
            if let optional = newValue as? AnyOptional, optional.isNil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                // or save
                userDefaults.set(newValue, forKey: key)
            }
        }
    }
}

struct SettingsStruct {
    @UserDefaultsWrapper(key: "preferredLanguage", defaultValue: "SP")
    static var preferredlanguage: String?
    
    @UserDefaultsWrapper(key: "dark Mode", defaultValue: false)
    static var darkMode: Bool
    
//    @UserDefaultsWrapper(key: "new Person", defaultValue: Person(name: "sample", favoriteColor: .red))
    static var person: Person!
}
