//
//  ExampleView.swift
//  Example2
//
//  Created by Maksim Gaiduk on 18/07/2023.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        VStack {
            Form {
                Section {
                    Text("Text1")
                    Text("Text1.1")
                    Text("Text1.2")
                }
                Section {
                    Text("Text2")
                }
                Section {
                    Text("Text3")
                }
            }
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
