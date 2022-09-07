//
//  Car.swift
//  CarListingApp
//
//  Created by Logan Doughty on 17/8/2022.
//

import Foundation

struct Car: Codable, Hashable {
    var consList: [String]
    var customerPrice: Double
    var make: String
    var marketPrice: Double
    var model: String
    var prosList: [String]
    var rating: Int
    
    var listingName: String {
        make + " " + model
    }
    
    var image: String {
        let carMake = make.replacingOccurrences(of: " ", with: "_")
        let carModel = model.replacingOccurrences(of: " ", with: "_")
        return carMake + "_" + carModel
    }
    
}
