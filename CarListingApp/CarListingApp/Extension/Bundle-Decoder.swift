//
//  jsonBundleExtension.swift
//  CarListingApp
//
//  Created by Logan Doughty on 14/8/2022.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        } //Get the URL Location of the Data

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        } //Try extract the Data from the url

        let decoder = JSONDecoder() //create a Decoder instance to read the data

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        } //attempt to read the Data obtained

        return loaded //return the decoded data
    }
}

