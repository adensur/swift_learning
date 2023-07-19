//
//  ContentView.swift
//  WeSplit
//
//  Created by Maksim Gaiduk on 19/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @FocusState private var isFocused
    @State private var numberOfPeopleSelectionIdx = 2 //
    @State private var selectedTip = 0
    private let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    private var totalAmountWithTip: Double {
        get {
            print("selected tip: ", selectedTip)
            print("Number of people selection idx: ", numberOfPeopleSelectionIdx)
            let amountWithTip = checkAmount * (1.0 + Double(selectedTip)/100.0)
            return amountWithTip
        }
    }
    private var perPersonAmount: Double {
        get {
            return totalAmountWithTip / Double((numberOfPeopleSelectionIdx + 1))
        }
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: currencyFormat)
                        .focused($isFocused)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Check amount")
                }
                Section {
                    Picker("Number of people ", selection: $numberOfPeopleSelectionIdx) {
                        ForEach(1..<100) {i in
                            Text("\(i) people")
                        }
                    }
                } header: {
                    Text("How many are you")
                }
                Section {
                    Picker("Tip", selection: $selectedTip) {
                        ForEach(0..<101) {i in
                            Text("\(i)%")
                        }
                    }
                } header: {
                    Text("Tip: ")
                }
                Section {
                    Text(totalAmountWithTip, format: currencyFormat)
                } header: {
                    Text("Total amount")
                }
                Section {
                    Text(perPersonAmount, format: currencyFormat)
                } header: {
                    Text("To pay per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
