//
//  ForgetPasswordModelView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import Combine
import CoreData

class ForgetPasswordViewModel: ObservableObject{
    @Published var email: String = ""
    
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
        
        if(verifyEmail()){
            alertTitle = "O email inserido não possui uma conta"
            return false
        }
        
        return true
    }
    
    func recoverPassword() -> Bool {
        if(!validate()){
            showAlert = true
            return false
        }
        
        self.alertTitle = "Email enviado"
        self.alertMessage = "Um email de recuperação de senha foi enviado ao email informado"
        self.showAlert = true
        
        return true
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
