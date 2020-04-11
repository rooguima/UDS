//
//  LoginViewModel.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class LoginViewModel: ObservableObject {
    @Published var user: User?
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    var objectContext: NSManagedObjectContext?

    func validate() -> Bool {
        if(email == ""){
            alertTitle = "Preencha o email"
            return false
        }
        
        if(!RegExHelper().isValidEmail(email)){
            alertTitle = "O email inserido não é valido"
            return false
        }
        
        if(password == ""){
            alertTitle = "Preencha a senha"
            return false
        }
        
        return true
    }
    
    func login() {
        if(!validate()){
            showAlert = true
            return
        }
        
        guard let context = objectContext else { return }
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", argumentArray: [email, password])

        if let result = try? context.fetch(fetchRequest) {
            if((result.first) != nil){
                UserDefaults.standard.set(String(describing: result.first!.id), forKey: "user_id")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            
                return
            }
        }
        
        alertTitle = "Conta não encontrada"
        showAlert = true
    }
}
