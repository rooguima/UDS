//
//  GuidelineListViewModel.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 09/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import Foundation
import Combine
import CoreData

class GuidelineListViewModel: ObservableObject {
    @Published var guidelines: [Guideline] = []
    @Published var status : [String] = ["Abertas", "Finalizadas"]
    @Published var closedFilter: Int = 0 {
        didSet {
            load()
        }
    }
    
    var objectContext: NSManagedObjectContext?
    
    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("guidelinesChange"), object: nil, queue: nil) { altered in
            self.load()
        }
    }
    
    func load() {
        guard let context = objectContext else { return }
    
        let fetchRequest = NSFetchRequest<Guideline>(entityName: "Guideline")
        fetchRequest.predicate = NSPredicate(format: "closed == %@", argumentArray: [closedFilter == 1])
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Guideline.createdAt), ascending: false)]
        
        if let result = try? context.fetch(fetchRequest) {
            guidelines = result
        }
    }
}
