public protocol Metric {

    static var name: String { get }

    init(_ files: [SourceFile])
    func measure() -> [ClassMetricResult]

}
