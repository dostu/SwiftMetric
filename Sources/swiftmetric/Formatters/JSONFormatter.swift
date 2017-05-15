import Foundation
import SwiftMetricFramework

public struct JSONFormatter: ResultsFormatter {

    let metricResults: [String: [ClassMetricResult]]

    public init(results: [String: [ClassMetricResult]]) {
        self.metricResults = results
    }

    public func format() -> String {
        let json = try! JSONSerialization.data(withJSONObject: resultsDictionary, options: .prettyPrinted)
        let text = String(data: json, encoding: .ascii)!.replacingOccurrences(of: "\\/", with: "/")
        return text
    }

    private var resultsDictionary: [[String: Any]] {
        var dictionary = [[String: Any]]()

        for (metric, results) in metricResults {
            for result in results {
                let classResultsIndex = dictionary.index { $0["class"] as? String == result.className && $0["path"] as? String == result.path }

                var classResults: [String: Any]

                if let index = classResultsIndex {
                    classResults = dictionary[index]
                } else {
                    classResults = ["path": result.path, "class": result.className]
                }
                classResults[metric] = result.value

                if let index = classResultsIndex {
                    dictionary[index] = classResults
                } else {
                    dictionary.append(classResults)
                }
            }
        }

        return dictionary
    }

}
