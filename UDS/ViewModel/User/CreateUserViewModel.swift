//
//  CreateuserViewModel.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import Combine
import CoreData

class CreateUserViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    var objectContext: NSManagedObjectContext?
    
    func validate() -> Bool {
        if(name == ""){
            alertTitle = "Preencha o nome"
            return false
        }
        
        if(email == ""){
            alertTitle = "Preencha o email"
            return false
        }
        
        if(!RegExHelper().isValidEmail(email)){
            alertTitle = "O email inserido não é valido"
            return false
        }
        
        if(!verifyEmail()){
            alertTitle = "O email inserido já possui uma conta"
            return false
        }
        
        if(password == ""){
            alertTitle = "Preencha a senha"
            return false
        }
        
        return true
    }
    
    func create() -> Bool {
        if(!validate()){
            showAlert = true
            return false
        }
        
        guard let context = objectContext else { return false }
      
        let managed = User(context: context)
        managed.id = UUID()
        managed.name = name
        managed.email = email
        managed.password = password
                                       
        do {
            try context.save()
            
            return true
        }catch{
            print(error)
        }
        
        return false
    }
    
    func verifyEmail() -> Bool {
        guard let context = objectContext else { return false }
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", argumentArray: [email])

        if let result = try? context.fetch(fetchRequest) {
            if((result.first) != nil){
                return false
            }
            
            return true
        } else {
            return false
        }
    }
}
