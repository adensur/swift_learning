//
//  ContentView.swift
//  MyAudioPlayerApp
//
//  Created by test on 4/18/23.
//

import SwiftUI

let defaultDeck = Deck()

class Deck: ObservableObject {
    @Published var currentCard: String? = nil
    
    func addCard() {
        self.currentCard = "NewCard"
    }
    
    func deleteCard() {
        currentCard = nil
    }
}

struct EditCardView: View {
    @ObservedObject var deck: Deck
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Button("Delete") {
                // Perform save action here
                // hack to update the parent view
                deck.deleteCard()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}



struct ContentView: View {
    @StateObject var deck: Deck
    var body: some View {
        NavigationView {
            VStack {
                Text("Hi!")
                if let currentCard = deck.currentCard {
                    Text("CurrentCard: \(deck.currentCard!)")
                        .onAppear {
                            print("OnAppear called, currentCard: \(currentCard)", Date())
                        }
                        .onDisappear {
                            print("onDisappear called, currentCard: \(currentCard)", Date())
                        }
                } else {
                    Text("Out of cards!")
                }
                Button("Add") {
                    deck.addCard()
                }
                if let currentCard = deck.currentCard {
                    NavigationLink {
                        EditCardView(deck: deck)
                    } label: {
                        Text("edit")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(deck: defaultDeck)
    }
}
