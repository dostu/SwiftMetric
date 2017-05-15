import Foundation
import SourceKittenFramework

public struct EfferentCouplingMetric: Metric {

    public static let name = "ce"

    let files: [SourceFile]

    public init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var results = [ClassMetricResult]()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let value = ClassEfferentCouplingFinder(classStructure).find().count
                let result = ClassMetricResult(className: classStructure.name, value: Double(value), path: file.path)
                results.append(result)
            }
        }

        return results
    }
    
}
