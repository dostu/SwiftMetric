import SwiftMetricFramework

protocol ResultsFormatter {

    init(results: [String: [ClassMetricResult]])
    func format() -> String

}
