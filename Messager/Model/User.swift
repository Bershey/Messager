//
//  User.swift
//  Messager
//
//  Created by minmin on 2021/09/30.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Codable, Equatable {
    var id = ""
    var username: String
    var email: String
    var pushId = ""
    var avaterLink = ""
    var status: String

    static var currentId: String {
        return Auth.auth().currentUser!.uid
    }

    static var currentUser: User? {
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.data(forKey: kCURRENTUSER){
            let decoder = JSONDecoder()
                do {
                    let object = try decoder.decode(User.self, from: dictionary)
                    return object
                } catch {
                    print("Error decoing user from user defaults", error.localizedDescription)
                }
            }
        }
        return nil
    }

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}
