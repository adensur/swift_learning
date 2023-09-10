import SwiftUI

struct MyView1: View {
    var body: some View {
        Text("MyView1")
    }
}

struct MyView2: View {
    var body: some View {
        Text("MyView2")
    }
}

struct ContentView : View {
    @State private var childViewPresented = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello!")
                NavigationLink {
                    MyView1()
                } label: {
                    Text("MyView1")
                }
                Button("MyView2") {
                    childViewPresented = true
                }
            }.navigationDestination(isPresented: $childViewPresented) {
                MyView2()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
