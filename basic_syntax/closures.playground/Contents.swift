import UIKit


func f() -> String {
    "Hello1"
    "Hello2"
}
print(f())

struct S {
    var v: String {
        "Hello2"
        "Hello3"
    }
}

var x = S()
print(x.v)
