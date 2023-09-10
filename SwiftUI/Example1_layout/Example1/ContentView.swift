import SwiftUI

struct OrderData: Codable {
    var quantity = 3
    var extraFrosting = false
    var name: String
    var counts: [Int]
}

class Order2: Codable, ObservableObject {
    @Published var data: OrderData
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(data, forKey: .data)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(OrderData.self, forKey: .data)
    }
}

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
}

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("Hello World")
    }
}


struct ContentView: View {
    @StateObject var order = Order()
    var body: some View {
        NavigationView {
            VStack {
//            Form {
//                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
//                }
//                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
//                }
//                Section {
//                    NavigationLink {
//                        AddressView(order: order)
//                    } label: {
//                        Text("Delivery details")
//                    }
//                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}
