//
//  DetailView.swift
//  Example2
//
//  Created by Maksim Gaiduk on 12/06/2023.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
            Text("TextInput")
            .overlay(alignment: .topTrailing) {
            Text("SuggestOptions")
                .frame(minHeight: 400)
                .background(Color.green)
                .offset(x: 25, y: 25)
                .opacity(0.5)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
