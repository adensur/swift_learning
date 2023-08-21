import SwiftUI
import Foundation

let a = "ढ़"
print("Initial string")
for point in a.unicodeScalars {
    print(point.value)
}
print("precomposedStringWithCanonicalMapping")
for point in a.precomposedStringWithCanonicalMapping.unicodeScalars {
    print(point.value)
}
