//
//  MyPresenter.swift
//  crud
//
//  Created by swift on 04.04.2024.
//
import RealmSwift
import Foundation
protocol MyPresenterLogic{
    func viewDidLoad()
    func buttonTap()
    func deleteUs(_ user: User)
    func updateUs(to name: String?, to surname: String?, to password: String?, at index: Int)
}
class MyPresenter{
    
    var view:MainView?
    
    let realm = try! Realm()
    var users = [User]()
    private func myButtonTapped(_ user:[User]){
        let user = User()
        try! realm.write {
            realm.add(user)
        }
        
        getUsers()
    }
    private func getUsers() {
        let users = realm.objects(User.self)
        
        self.users = users.map({ user in
            user
        })
    }
    private func deleteUser( user: User){
        try! realm.write {
            realm.delete(user)
        }
    }
    private func updateUserName(to name: String?, to surname: String?, to password: String?, at index: Int) {
        
        let user = realm.objects(User.self)[index]
        
        try! realm.write ({
            if let name = name, !name.isEmpty {
                user.name = name
            }
            if let surname = surname, !surname.isEmpty {
                user.surname = surname
            }
            if let password = password, !password.isEmpty {
                user.password = password
            }
        })

    }
    
    
}
extension MyPresenter:MyPresenterLogic{
    
    func viewDidLoad() {
        getUsers()
    }
    func buttonTap(){
        myButtonTapped(users)
    }
    func deleteUs(_ user: User){
        deleteUser(user: user)
    }
    func updateUs(to name: String?, to surname: String?, to password: String?, at index: Int){
        updateUserName(to: name, to: surname, to: password, at: index)
    }
}
