struct MethodPair: Hashable {

    let methodA: String
    let methodB: String

    static func == (lhs: MethodPair, rhs: MethodPair) -> Bool {
        return lhs.methodA == rhs.methodA && lhs.methodB == rhs.methodB
            || lhs.methodA == rhs.methodB && lhs.methodB == rhs.methodA
    }

    var hashValue: Int {
        return methodA.hashValue ^ methodB.hashValue
    }
    
}
