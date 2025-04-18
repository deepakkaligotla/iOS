//
//  Item.swift
//  AllComponentsNew
//
//  Created by Deepak Kaligotla on 01/06/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
