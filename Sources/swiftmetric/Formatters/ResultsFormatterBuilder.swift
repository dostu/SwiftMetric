import Foundation

struct ResultsFormatterBuilder {

    enum ResultsFormat: String {
        case csv
        case json
    }

    let format: String

    func build() throws -> ResultsFormatter.Type {
        guard let format = ResultsFormat(rawValue: format) else {
            throw SwiftMetricError.unknownMetric
        }

        switch format {
        case .csv:
            return CSVFormatter.self
        case .json:
            return JSONFormatter.self
        }
    }

}
