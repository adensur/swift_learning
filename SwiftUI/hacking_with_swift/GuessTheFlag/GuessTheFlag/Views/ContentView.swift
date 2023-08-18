//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maksim Gaiduk on 20/07/2023.
//

import SwiftUI



struct ContentView: View {
    @State private var flag = false
    @State private var name = ""
    @State private var navPath = NavigationPath()
    @State private var navigationStack: [Int] = []
    @StateObject var highScores: HighScores
    var body: some View {
        NavigationStack(path: $navigationStack) {
            ZStack {
                LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.46), Color(red: 0.66, green: 0.2, blue: 0.26)], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0, y: 1))
                    .ignoresSafeArea()
                Form {
                    Group {
                        Section {
                            TextField(text: $name, prompt: Text("Enter your name").foregroundColor(Color.gray)) { }
                                .foregroundColor(Color.black)
                        } header: {
                            Text("Player Name").foregroundStyle(Color(red: 0.66, green: 0.2, blue: 0.26))
                        }
                        Section {
                            HStack {
                                Spacer()
                                Button("Play!") {
                                    navigationStack.append(0)
                                }
                                Spacer()
                            }
                        }
                    }.listRowBackground(Color.white.opacity(0.9))
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: Int.self) {i in
                    if i == 0 {
                        PlayView(name: name) {score in
                            highScores.addScore(name: name, score: score)
                            let _ = navigationStack.popLast()
                            navigationStack.append(1)
                        }
                    } else if i == 1 {
                        HighScoresView(highScores: highScores) {
                            let _ = navigationStack.popLast()
                            name = ""
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(highScores: HighScores())
    }
}
