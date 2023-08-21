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
    @Environment(\.dismiss) var dismiss
    var callback: () -> Void
    var body: some View {
        NavigationView {
            Button("Delete") {
                // Perform save action here
                // hack to update the parent view
                deck.deleteCard()
                dismiss()
//                callback()
            }
        }
    }
}



struct ContentView: View {
    @ObservedObject var deck: Deck
    @State private var navigationStack: [Int] = []
    var body: some View {
        NavigationStack(path: $navigationStack) {
            VStack {
                Text("Hi!")
                if let currentCard = deck.currentCard {
                    Text("CurrentCard: \(deck.currentCard!)")
                        .onAppear {
                            print("OnAppear called, text: \(deck.currentCard!)", Date())
                        }
                } else {
                    Text("Out of cards!")
                }
                Button("Add") {
                    deck.addCard()
                }
                if let currentCard = deck.currentCard {
                    Button("Edit") {
                        navigationStack.append(0)
                    }
                }
            }
            .navigationDestination(for: Int.self) {i in
                EditCardView(deck: deck) {
                    let _ = navigationStack.popLast()
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
