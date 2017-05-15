import Foundation

public struct LinesOfCodeMetric: Metric {

    public static let name = "loc"

    let files: [SourceFile]

    public init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var results = [ClassMetricResult]()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let lines = ClassLinesOfCodeCalculator(classStructure, file: file).calculate()
                let result = ClassMetricResult(className: classStructure.name, value: Double(lines), path: file.path)
                results.append(result)
            }
        }

        return results
    }

}
