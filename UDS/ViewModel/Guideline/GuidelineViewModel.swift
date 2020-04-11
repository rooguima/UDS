//
//  GuidelineViewModel.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 09/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import Combine
import CoreData

class GuidelineViewModel: ObservableObject {

    @Published var guideline: Guideline?
    var objectContext: NSManagedObjectContext?
    
    func close() {
        guard let context = objectContext else { return }
        
        guideline!.closed = !guideline!.closed
        
        do {
            try context.save()
            
            NotificationCenter.default.post(name: NSNotification.Name("guidelinesChange"), object: guideline)
        }catch{
            print(error)
        }
    }
}
