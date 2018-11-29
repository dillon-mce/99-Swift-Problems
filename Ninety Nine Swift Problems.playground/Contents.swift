//import Foundation

/// A list is either empty or it is composed of a first element (head) and a tail, which is a list itself.
class List<T> {
    var value: T
    var nextItem: List<T>?
    
    convenience init?(_ values: T...) {
        self.init(Array(values))
    }
    
    init?(_ values: [T]) {
        guard let first = values.first else {
            return nil
        }
        value = first
        nextItem = List(Array(values.suffix(from: 1)))
    }
}

extension List: CustomStringConvertible {
    var description: String {
        var string = "List with elements: "
        for i in 0..<self.length {
            string += i != (self.length - 1) ? "\(self[i]!), " : "\(self[i]!)"
        }
        return string
    }
}

extension List: Equatable where T: Equatable {
    static func == (lhs: List, rhs: List) -> Bool {
        guard lhs.length == rhs.length else { return false }
        
        for i in 0..<lhs.length {
            if lhs[i] != rhs[i] { return false }
        }
        
        return true
    }
}

let list1 = List(1, 1, 2, 3, 5, 8, 13)!
let list2 = List(1, 2, 1)!
let list3 = List(1)!

// P01 - Last element
extension List {
    var last: T? {
        return nextItem != nil ? nextItem!.last : value
    }
}

list1.last // 13
list2.last // 1
list3.last // 1

// P02 - Last but one element
extension List {
    var penultimate: T? {
        guard let nextItem = nextItem else { return nil }
        return nextItem.nextItem != nil ? nextItem.penultimate : value
    }
}

list1.penultimate // 8
list2.penultimate // 2
list3.penultimate // nil

// P03 - Kth element
extension List {
    subscript(index: Int) -> T? {
        var list = self
        for i in 0...index {
            if i == index { return list.value }
            guard let nextItem = list.nextItem else { return nil }
            list = nextItem
        }
        return nil
    }
}

list1[4] // 5
list2[3] // nil
list3[0] // 1

// P04 - Length
extension List {
    var length: Int {
        var list = self
        var count = 1
        while list.nextItem != nil {
            count += 1
            list = list.nextItem!
        }
        return count
    }
}

list1.length // 7
list2.length // 3
list3.length // 1

// P05 - Reverse
extension List {
    func reverse() -> List? {
        var list: List? = nil
        for i in 0..<self.length {
            guard let item = self[i] else { continue }
            var temp = List(item)
            temp?.nextItem = list
            list = temp
        }
        return list
    }
}

list1.reverse()
list2.reverse()
list3.reverse()

// P06 - Palindrome
extension List where T: Equatable {
    func isPalindrome() -> Bool {
        return self == self.reverse()
    }
}

list1.isPalindrome() // false
list2.isPalindrome() // true
list3.isPalindrome() // true
