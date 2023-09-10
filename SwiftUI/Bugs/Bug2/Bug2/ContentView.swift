//
//  ContentView.swift
//  Bug2
//
//  Created by Maksim Gaiduk on 10/09/2023.
//

import SwiftUI

struct Subview: View {
    @State private var isPresented = false
    var body: some View {
        VStack {
            Text("Subview")
            Button("Screen3") {
                isPresented = true
            }
        }
            .navigationDestination(isPresented: $isPresented) {
                Screen3()
            }
    }
}

struct Screen1: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Screen1")
            NavigationLink("Screen2") {
                Screen2() {
                    dismiss()
                }
            }
            Subview()
        }
        
    }
}

struct Screen2: View {
    @Environment(\.dismiss) var dismiss
    var callback: () -> Void
    var body: some View {
        VStack {
            Text("Screen2")
            Button("Dismiss") {
                dismiss()
                callback()
            }
        }
    }
}

struct Screen3: View {
    var body: some View {
        Text("Screen3")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("BaseScreen")
            }
            NavigationLink("Screen1") {
                Screen1()
            }
        }
    }
}
