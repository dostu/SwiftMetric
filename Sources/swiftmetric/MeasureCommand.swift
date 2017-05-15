import Foundation
import Commandant
import Result
import SwiftMetricFramework

struct MeasureCommand: CommandProtocol {

    typealias Options = MeasureOptions

    let verb = "measure"
    let function = "Measures metrics"

    func run(_ options: Options) -> Result<(), SwiftMetricError> {
        do {
            let formatter = try ResultsFormatterBuilder(format: options.format).build()
            let metrics = try MetricListBuilder(metrics: options.metrics).build()
            let files = FileFinder(paths: options.path).find()

            let results = MetricResultsCalculator(files: files, metrics: metrics).calculate()
            let formattedResults = formatter.init(results: results).format()

            print(formattedResults)
        } catch {
            return .failure(error as! SwiftMetricError)
        }

        return .success()
    }

}

struct MeasureOptions: OptionsProtocol {

    let format: String
    let metrics: [String]
    let path: [String]

    static func create(_ format: String) -> ([String]) -> ([String]) -> MeasureOptions {
        return { metrics in { path in
            MeasureOptions(format: format, metrics: metrics, path: path)
        }}
    }

    static func evaluate(_ m: CommandMode) -> Result<MeasureOptions, CommandantError<SwiftMetricError>> {
        return create
            <*> m <| Option(key: "format", defaultValue: "csv", usage: "output format")
            <*> m <| Option(key: "metrics", defaultValue: [], usage: "metrics to measure")
            <*> m <| Argument(defaultValue: [], usage: "path to files")
    }

}
