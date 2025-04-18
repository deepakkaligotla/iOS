//
//  UICategory+CoreDataProperties.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 04/05/24.
//
//

import Foundation
import CoreData


extension UICategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UICategory> {
        return NSFetchRequest<UICategory>(entityName: "UICategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var component: NSSet?

}

// MARK: Generated accessors for component
extension UICategory {

    @objc(addComponentObject:)
    @NSManaged public func addToComponent(_ value: UIComponent)

    @objc(removeComponentObject:)
    @NSManaged public func removeFromComponent(_ value: UIComponent)

    @objc(addComponent:)
    @NSManaged public func addToComponent(_ values: NSSet)

    @objc(removeComponent:)
    @NSManaged public func removeFromComponent(_ values: NSSet)

}

extension UICategory : Identifiable {

}
