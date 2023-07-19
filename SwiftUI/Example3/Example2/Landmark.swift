//
//  Landmark.swift
//  Example2
//
//  Created by Maksim Gaiduk on 23/02/2023.
//

import Foundation
import SwiftUI

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String

    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
