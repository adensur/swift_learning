//
//  PlayStartView.swift
//  GuessTheFlag
//
//  Created by Maksim Gaiduk on 12/08/2023.
//

import SwiftUI

struct PlayStartView: View {
    @Binding var name: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TextField("Enter your name: ", text: $name)
            .onSubmit {
                dismiss()
            }
    }
}

#Preview {
    PlayStartView(name: .constant("Max"))
}
