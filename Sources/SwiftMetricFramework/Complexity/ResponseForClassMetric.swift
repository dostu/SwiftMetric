import Foundation
import SourceKittenFramework

public struct ResponseForClassMetric: Metric {

    public static let name = "rfc"

    let files: [SourceFile]

    public init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var metricResults = [ClassMetricResult]()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let classResult = ResponseForClassCalculator(classStructure).calculate()
                let result = ClassMetricResult(className: classStructure.name, value: Double(classResult), path: file.path)
                metricResults.append(result)
            }
        }

        return metricResults
    }
    
}
