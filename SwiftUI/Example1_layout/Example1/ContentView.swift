import SwiftUI

struct MyView : View {
    @Environment(\.dismiss) var dismiss
    @Binding var count: Int
    var body: some View {
        print("MyView body called!")
        Self._printChanges()
        return VStack {
            Text("MyView! Count: \(count)")
            NavigationLink("SomeOtherView") {
                Text("SomeOtherViewHere")
            }
        }
    }
}

struct ContentView: View {
    @State private var count = 0
    var body: some View {
        NavigationStack {
            List {
                MyView(count: $count)
                Button("Tap me!") {
                    count += 1
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

