//
//  PreferenceManager.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/10.
//

import Foundation
import Combine

public final class PreferenceManager {
    public static let shared: PreferenceManager = PreferenceManager()
    
    /// UserDefaults에 저장 된 데이터에 접근하기 위한 키 값의 나열.
    enum Constants: String {
        case id
        case firstExchange
    }
    
    @UserDefaultWrapper(key: Constants.id.rawValue, defaultValue: nil)
    public static var id: String?
    
    @UserDefaultWrapper(key: Constants.firstExchange.rawValue, defaultValue: true)
    public static var firstExchange: Bool?
}

@propertyWrapper
public final class UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?

    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            } else if UserDefaults.standard.array(forKey: key) != nil {
                return UserDefaults.standard.array(forKey: key) as? T
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
            subject.send(newValue)
        }
    }
    
    private lazy var subject: CurrentValueSubject<T?, Never> = CurrentValueSubject<T?, Never>(wrappedValue)
    public var projectedValue: AnyPublisher<T?, Never> {
        subject.eraseToAnyPublisher()
    }
}
