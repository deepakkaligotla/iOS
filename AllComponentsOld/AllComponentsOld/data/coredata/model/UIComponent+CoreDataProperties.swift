//
//  UIComponent+CoreDataProperties.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 04/05/24.
//
//

import Foundation
import CoreData


extension UIComponent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UIComponent> {
        return NSFetchRequest<UIComponent>(entityName: "UIComponent")
    }

    @NSManaged public var name: String?
    @NSManaged public var vcIdentifier: String?
    @NSManaged public var category: UICategory?

}

extension UIComponent : Identifiable {

}
