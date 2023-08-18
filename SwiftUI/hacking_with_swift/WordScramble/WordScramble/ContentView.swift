//
//  ContentView.swift
//  WordScramble
//
//  Created by Maksim Gaiduk on 18/08/2023.
//

import SwiftUI

func loadRootWords() -> [String] {
    let url = Bundle.main.url(forResource: "start", withExtension: ".txt")!
    let str = try! String(contentsOf: url)
    return str.components(separatedBy: "\n")
}

let rootWords = loadRootWords()

struct ContentView: View {
    @State private var rootWord = rootWords.randomElement()!
    @State private var word = ""
    @State private var words: [String] = []
    
    @State private var alertLabel = ""
    @State private var alertMessage = ""
    @State private var alertPresented = false
    var score: Int {
        return words.reduce(0) {prevScore, word in
            prevScore + word.count}
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("", text: $word)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .onSubmit {
                            addWord(word)
                        }
                } header : {
                    Text("Input your word:")
                }
                ForEach(words, id: \.self) {word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text("\(word)")
                    }
                }
                Section {
                    Text("Total score: \(score)")
                }
            }
            .alert(alertLabel, isPresented: $alertPresented) {
                Button("Ok") { }
            } message: {
                Text(alertMessage)
            }
            .navigationTitle("\(rootWord)")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Restart") {
                        restartGame()
                    }
                }
            }
        }
        .padding()
    }
    
    func restartGame() {
        word = ""
        words = []
        rootWord = rootWords.randomElement()!
    }
    
    func showAlert(label: String, text: String) {
        alertLabel = label
        alertMessage = text
        alertPresented = true
        word = ""
    }
    
    func addWord(_ wordToAdd: String) {
        if !isWordPossible(wordToAdd) {
            showAlert(label: "Word is not possibe!", text: "Pay attention!")
            return
        }
        if !isWordUnique(wordToAdd) {
            showAlert(label: "Word already exists!", text: "Try to come up with a unique word!")
            return
        }
        if !isWordWord(wordToAdd) {
            showAlert(label: "That's not a word", text: "WTF dude?")
            return
        }
        if wordToAdd == rootWord {
            showAlert(label: "That's just the root word repeated", text: "Some originality, perhaps?")
            return
        }
        if wordToAdd.count < 3 {
            showAlert(label: "The word must have at least 3 letters", text: "Can't have them too short now, can we?")
            return
        }
        words.insert(wordToAdd, at: 0)
        word = ""
    }
    
    func isWordPossible(_ word: String) -> Bool {
        var wordCopy = rootWord
        for character in word {
            if let idx = wordCopy.firstIndex(of: character) {
                wordCopy.remove(at: idx)
            } else {
                return false
            }
        }
        return true
    }
    
    func isWordWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func isWordUnique(_ word: String) -> Bool {
        return !words.contains(word)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
