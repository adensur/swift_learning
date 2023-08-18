//
//  PlayView.swift
//  GuessTheFlag
//
//  Created by Maksim Gaiduk on 06/08/2023.
//

import SwiftUI

struct PlayView: View {
    static let allCountries = [
        "Estonia", "France", "Sweden", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US",
    ]
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var chosenAnswer = 0
    @State private var showAlert = false
    @State private var score = 0
    @State private var showFinishAlert = false
    // The game will call the callback with the score at the end of the round
    var name: String
    var callback: (Int) -> Void
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.46), location: 0.99),
                .init(color: Color(red: 0.66, green: 0.2, blue: 0.26), location: 1)
            ], center: .top, startRadius: 0, endRadius: 500)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Current player: \(name)")
                    .foregroundColor(Color.white)
                Text("Guess the flag")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                Spacer()
                VStack(spacing: 15) {
                    if countries.count >= 3 {
                        Spacer()
                        Spacer()
                        Text("Tap the flag of")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        Text("\(countries[correctAnswer])")
                            .font(.title)
                        Spacer()
                        ForEach(0..<3) {i in
                            Image(countries[i])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .onTapGesture {
                                    imageTapped(i)
                                }
                        }
                        Spacer()
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.secondary)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                Spacer()
                Spacer()
                Text("Score: \(score)")
                Button("Finish") {
                    callback(score)
                }
                Spacer()
            }
        }
        .alert(
            chosenAnswer == correctAnswer ? Text("That's right!") : Text("Not quite!"),
            isPresented: $showAlert) {
                Button("OK") {
                    reset(chosenAnswer == correctAnswer)
                }
            } message: {
                if chosenAnswer != correctAnswer {
                    Text("That was the flag of \(countries[chosenAnswer])")
                }
            }
            .alert(
                Text("You won!"),
                isPresented: $showFinishAlert) {
                    Button("OK") {
                        print("Exiting#2")
                        withAnimation {
                            callback(score)
                        }
                    }
                } message: {
                    Text("Your final score is: \(score)")
                }
    }
    
    func imageTapped(_ i: Int) {
        chosenAnswer = i
        if chosenAnswer == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
        showAlert = true
    }
    
    func reset(_ isAnswerCorrect: Bool) {
        if isAnswerCorrect {
            countries.remove(at: chosenAnswer)
        }
        print("Countries len: \(countries.count)")
        if countries.count < 3 {
            // exit!
            print("Exiting!")
            showFinishAlert = true
        }
        correctAnswer = Int.random(in: 0..<3)
        countries = countries.shuffled()
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView(name: "Max") {_ in }
    }
}
