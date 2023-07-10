//
//  FireBaseManager.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/08.
//

import Foundation
import Firebase

final class FireBaseDataBaseManager {
    public static let shared = Database.database().reference()
}
