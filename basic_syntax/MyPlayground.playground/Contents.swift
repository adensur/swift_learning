import SwiftUI
import Foundation

let data = Data("abcd,efgh".utf8)
print(data)
let values = data.split(separator: Character(",").asciiValue!)
let value = values[1]
let subdata = data[1..<value.count - 1]
print(subdata)
let str = String(decoding: subdata, as: UTF8.self)
print(str)
