//
//  HighScoresView.swift
//  GuessTheFlag
//
//  Created by Maksim Gaiduk on 12/08/2023.
//

import SwiftUI

struct HighScoresView: View {
    @ObservedObject var highScores: HighScores
    var lastId: Int {
        highScores.scores.last!.id
    }
    var callback: () -> Void
    var sortedScores: [Score] {
        highScores.scores.sorted {lhs, rhs in
            lhs.score < rhs.score
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.46), Color(red: 0.66, green: 0.2, blue: 0.26)], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0, y: 1))
                .ignoresSafeArea()
            
            VStack {
                Text("High Scores")
                ForEach(sortedScores, id: \.id) {score in
                    HStack {
                        Text("\(score.name): \(score.score)")
                            .foregroundColor(score.id == lastId ? .black : .white)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .border(Color.white)
                    .background(score.id == lastId ? Color.yellow : Color.black.opacity(0))
                    .padding(EdgeInsets(top: 1, leading: 10, bottom: 0, trailing: 10))
                }
                Spacer()
                Button {
                    callback()
                } label: {
                    Text("Dismiss").foregroundColor(Color.white)
                }
            }
        }
    }
}

#Preview {
    HighScoresView(highScores: previewScores) {
    }
}
