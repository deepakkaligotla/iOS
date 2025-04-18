//
//  CreateData.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 05/05/24.
//

import UIKit
import CoreData

extension MainVC {
    func createItems() {
        do {
            if try self.managedObjectContext.count(for: UIComponent.fetchRequest()) != UIData.totalUICount {
                try self.managedObjectContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "UICategory")))
                try self.managedObjectContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "UIComponent")))
                
                for category in UICategories.allCases {
                    createCategories(for: category)
                }
            }
        } catch {
            print("Error creating entities: \(error)")
        }
    }
    
    private func createCategories(for category: UICategories) {
        let categoryEntity = UICategory(context: self.managedObjectContext)
        categoryEntity.name = category.rawValue
        
        switch category {
        case .AllContent:
            createComponents(categoryType: AllContent.self, categoryEntity: categoryEntity)
        case .Layout_Organisation:
            createComponents(categoryType: Layout_Organisation.self, categoryEntity: categoryEntity)
        case .Menu_Actions:
            createComponents(categoryType: Menu_Actions.self, categoryEntity: categoryEntity)
        case .Navigation_Search:
            createComponents(categoryType: Navigation_Search.self, categoryEntity: categoryEntity)
        case .AllPresentations:
            createComponents(categoryType: AllPresentations.self, categoryEntity: categoryEntity)
        case .Selection_Input:
            createComponents(categoryType: Selection_Input.self, categoryEntity: categoryEntity)
        case .AllStatus:
            createComponents(categoryType: AllStatus.self, categoryEntity: categoryEntity)
        case .SystemExperiences:
            createComponents(categoryType: SystemExperiences.self, categoryEntity: categoryEntity)
        }
    }
    
    private func createComponents<T: CaseIterable>(categoryType: T.Type, categoryEntity: UICategory) where T: RawRepresentable, T.RawValue == String {
        for component in categoryType.allCases {
            let componentEntity = UIComponent(context: self.managedObjectContext)
            componentEntity.name = component.rawValue
            componentEntity.vcIdentifier = component.rawValue.replacingOccurrences(of: " ", with: "") + "VC"
            componentEntity.category = categoryEntity // Establishing the relationship
            // categoryEntity.addToComponent(componentEntity) // Alternative approach
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Error saving to CoreData - \(error)")
            }
        }
    }
}
