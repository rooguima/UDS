//
//  ProfileViewModel.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import Combine
import CoreData

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    
    var objectContext: NSManagedObjectContext?
    
    func load() {
        guard let context = objectContext else { return }
        
        let user_id = UserDefaults.standard.value(forKey: "user_id") ?? ""
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [UUID(uuidString: user_id as! String) ?? ""])
        
        if let result = try? context.fetch(fetchRequest) {
            user = result.first!
        }
    }
    
    func logout() {
        UserDefaults.standard.set(String(), forKey: "user_id")
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
    }
}
