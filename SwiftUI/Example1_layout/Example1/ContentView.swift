import SwiftUI

struct StatefulView : View {
    @Binding var count: Int
    var body: some View {
        VStack {
            Text("Count: \(count)")
            Button("Tap me!") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
}


struct ContentView: View {
    @State private var count = 0
    var body: some View {
        VStack {
            Canvas { ctx, size in
                if let shape = ctx.resolveSymbol(id: "id1") {
                    ctx.draw(shape, at: CGPoint(x: 250, y:
                                                    300))
                }
            } symbols: {
                StatefulView(count: $count)
                    .frame(width: 100, height: 100)
                    .tag("id1")
            }
            Button("Tap me2") {
                count += 1
            }
        }
    }
}

#Preview {
    ContentView()
}

