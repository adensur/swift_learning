//
//  HighScores.swift
//  GuessTheFlag
//
//  Created by Maksim Gaiduk on 17/08/2023.
//

import Foundation

struct Score: Codable {
    let name: String
    let score: Int
    let id: Int
}

class HighScores: Codable, ObservableObject {
    @Published private(set) var scores: [Score] = []
    var maxId: Int = 0
    init() {
    }
    
    func addScore(name: String, score: Int) {
        self.scores.append(.init(name: name, score: score, id: maxId))
        maxId += 1
    }
    
    enum CodingKeys: CodingKey {
        case scores, maxId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(scores, forKey: .scores)
        try container.encode(maxId, forKey: .maxId)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        scores = try container.decode([Score].self, forKey: .scores)
        maxId = try container.decode(Int.self, forKey: .maxId)
    }
    
    func save() {
        print("saving scores!", Date())
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(self)

        // Write the JSON data to a file
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("data.json")
        try! jsonData.write(to: fileURL)
    }
    
    static func load() -> HighScores {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("data.json")
    //    let fileURL = Bundle.main.url(forResource: "data", withExtension: "json")!
        if let jsonData = try? Data(contentsOf: fileURL) {
            print(fileURL)
            // Decode the JSON data into the structure
            let decoder = JSONDecoder()
            let deck = try! decoder.decode(HighScores.self, from: jsonData)
            return deck
        } else {
            return HighScores()
        }
    }
    
    static func loadPreview() -> HighScores {
        let result = HighScores()
        result.addScore(name: "Max", score: 55)
        result.addScore(name: "Eric", score: 35)
        return result
    }
}

var defaultScores = HighScores.load()
var previewScores = HighScores.loadPreview()
