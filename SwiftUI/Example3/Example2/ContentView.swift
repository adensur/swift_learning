//
//  ContentView.swift
//  Example2
//
//  Created by Maksim Gaiduk on 23/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    var body: some View {
        VStack {
            TextField(
                "Input text",
                text: $text
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)

            Text(text)
                .foregroundColor(.blue)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
