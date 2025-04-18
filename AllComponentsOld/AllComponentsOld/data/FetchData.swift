//
//  FetchData.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 05/05/24.
//

import Foundation
import CoreData
import UIKit

class FetchData {
    var uiCategories: [UICategory] = []
    var uiComponents: [UIComponent] = []
    var selectedCategoryComponents: [UIComponent] = []
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllCategories() -> [UICategory] {
        do {
            if try self.managedObjectContext.count(for: UICategory.fetchRequest()) == UICategories.allCases.count {
                self.uiCategories = try managedObjectContext.fetch(UICategory.fetchRequest())
                return self.uiCategories
            }
        } catch {
            print("Error fetching data - \(error)")
        }
        return self.uiCategories
    }
    
    func getAllComponents() -> [UIComponent] {
        do {
            if try self.managedObjectContext.count(for: UIComponent.fetchRequest()) == UIData.totalUICount {
                self.uiComponents = try managedObjectContext.fetch(UIComponent.fetchRequest())
                return self.uiComponents
            }
        } catch {
            print("Error fetching data - \(error)")
        }
        return self.uiComponents
    }
    
    func getCategoryComponents(selectedCategory: String) -> [UIComponent] {
        do {
            let req = UIComponent.fetchRequest()
            req.predicate = NSPredicate(format: "category.name LIKE[c] %@", "\(selectedCategory)*")
            req.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            self.selectedCategoryComponents = try managedObjectContext.fetch(req)
            return selectedCategoryComponents
        } catch {
            print("Error getting selected category components - \(error)")
        }
        return selectedCategoryComponents
    }
}
