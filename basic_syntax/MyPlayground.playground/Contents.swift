import SwiftUI
import Foundation

var lastRepetition = Date()
var interval = TimeInterval(1)
let nextRepetition: Date = lastRepetition + interval
print(type(of: nextRepetition))
var i = nextRepetition.timeIntervalSince(Date())

print(i)
