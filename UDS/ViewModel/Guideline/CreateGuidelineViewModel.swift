//
//  CreateGuidelineViewModel.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import Combine
import CoreData

class CreateGuidelineViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var briefDescription: String = ""
    @Published var fullDescription: String = ""
    @Published var user: User?
    
    var objectContext: NSManagedObjectContext?
    
    func enableButton() -> Bool {
        if(title.count > 0 && briefDescription.count > 0 && fullDescription.count > 0){
            return true
        }
        return false
    }
    
    func save() {
        guard let context = objectContext else { return }
        
        let guideline = Guideline(context: context)
        guideline.id = UUID()
        guideline.title = self.title
        guideline.briefDescription = self.briefDescription
        guideline.fullDescription = self.fullDescription
        guideline.closed = false
        guideline.createdAt = Date()
        guideline.author = self.user!
        
        do {
            try context.save()
        }catch{
            print(error)
        }
    }
}
