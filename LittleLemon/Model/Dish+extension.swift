//
//  Dish+extension.swift
//  LittleLemon
//
//  Created by Jo Michael on 3/15/23.
//

import Foundation
import CoreData

extension Dish {
    class func saveDatabase(_ context:NSManagedObjectContext) {
        guard context.hasChanges else { return}
        do {
            try context.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
