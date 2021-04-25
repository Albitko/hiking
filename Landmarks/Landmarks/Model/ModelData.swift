//
//  ModelData.swift
//  Landmarks
//
//  Created by Alex on 18.04.2021.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    
    var features: [Landmark] {
            landmarks.filter { $0.isFeatured }
    }
    
    
    var categories: [String: [Landmark]] {
            Dictionary(
                grouping: landmarks,
                by: { $0.category.rawValue }
            )
        }
}



func load<Type: Decodable>(_ filename: String) -> Type{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(Type.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(Type.self):\n\(error)")
    }
}
