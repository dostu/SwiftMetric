import Foundation
import SwiftMetricFramework

class ClassMetricsResults {

    let className: String
    let path: String
    var metricResults = [String: Double]()

    init(className: String, path: String) {
        self.className = className
        self.path = path
    }

}

public struct CSVFormatter: ResultsFormatter {

    let metricResults: [String: [ClassMetricResult]]

    public init(results: [String: [ClassMetricResult]]) {
        self.metricResults = results
    }

    public func format() -> String {
        let metrics = Array(metricResults.keys)
        let headerElements = ["path", "class"] + metrics
        let header = headerElements.joined(separator: ",")
        let results = formattedResults(metrics: metrics)
        let allLines = [header] + results
        return allLines.joined(separator: "\n")
    }

    private func formattedResults(metrics: [String]) -> [String] {
        return resultsDictionary.map { classResults in
            let values: [String] = metrics.map { metric in
                guard let value = classResults.metricResults[metric] else {
                    return ""
                }

                return String(value)
            }

            let results = [classResults.path, classResults.className] + values
            return results.joined(separator: ",")
        }
    }

    private var resultsDictionary: [ClassMetricsResults] {
        var dictionary = [ClassMetricsResults]()

        for (metric, results) in metricResults {
            for result in results {
                if let classResults = dictionary.first(where: { $0.className == result.className && $0.path == result.path }) {
                    classResults.metricResults[metric] = result.value
                } else {
                    let classResults = ClassMetricsResults(className: result.className, path: result.path)

                    classResults.metricResults[metric] = result.value

                    dictionary.append(classResults)
                }
            }
        }
        
        return dictionary
    }
    
}
