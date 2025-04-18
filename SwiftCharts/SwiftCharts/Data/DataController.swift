//
//  DataController.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import Foundation
import SwiftData

class DataController: ObservableObject {
    var modelContext: ModelContext? = nil

    init(context: ModelContext?) {
        self.modelContext = context
    }

    func loadAddressData(searchPincode: Int) {

        
    }

    private func saveContext() {
        do {
            try modelContext?.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
