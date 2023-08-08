import SwiftUI
import Foundation

func findValueOfPartition(_ nums: [Int]) -> Int {
    let sortedNums = nums.sorted()
    var minDelta = sortedNums[1] - sortedNums[0]
    for i in 1..<sortedNums.count {
        let delta = sortedNums[i] - sortedNums[i - 1]
        if delta < minDelta {
            minDelta = delta
        }
    }
    return minDelta
}

print(findValueOfPartition([84,11,100,100,75]))
