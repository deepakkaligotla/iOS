//
//  DataModels.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 16/08/24.
//

import SwiftUI

struct DyskineticSymptomData {
    var startDate: Date
    var endDate: Date
    var percentUnlikely: Float
    var percentLikely: Float
}

struct TremorData {
    var startDate: Date
    var endDate: Date
    var percentUnknown: Float
    var percentNone: Float
    var percentSlight: Float
    var percentMild: Float
    var percentModerate: Float
    var percentStrong: Float
}
