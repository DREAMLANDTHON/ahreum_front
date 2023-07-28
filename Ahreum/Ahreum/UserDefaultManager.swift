//
//  UserDefaultManager.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

struct UserDefaultManager {
    static let shared = UserDefaultManager()
    
    enum UserDefaultKey: String, CaseIterable {
        case todayBallCount
        case usingBallCount
    }
    
    func resetAllUserDefault() {
        var key = UserDefaultKey.todayBallCount.rawValue
        UserDefaults.standard.removeObject(forKey: key)
        key = UserDefaultKey.usingBallCount.rawValue
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    // todayBallCount
    func saveTodayBallCount(num: Int) {
        let key = UserDefaultKey.todayBallCount.rawValue
        UserDefaults.standard.set(num, forKey: key)
    }
    
    func getTodayBallCount() -> Int? {
        let key = UserDefaultKey.todayBallCount.rawValue
        if let count = UserDefaults.standard.object(forKey: key) as? Int {
            return count
        } else {
            return nil
        }
    }
    
    // usingBallCount
    func saveUsingBallCount(num: Int) {
        let key = UserDefaultKey.usingBallCount.rawValue
        UserDefaults.standard.set(num, forKey: key)
    }
    
    func addUsingBallCount() {
        let key = UserDefaultKey.usingBallCount.rawValue
        let count = UserDefaults.standard.object(forKey: key) as? Int ?? 0
        UserDefaults.standard.set(count + 1, forKey: key)
    }
    func getUsingBallCount() -> Int? {
        let key = UserDefaultKey.usingBallCount.rawValue
        if let count = UserDefaults.standard.object(forKey: key) as? Int {
            return count
        } else {
            return nil
        }
    }
}
