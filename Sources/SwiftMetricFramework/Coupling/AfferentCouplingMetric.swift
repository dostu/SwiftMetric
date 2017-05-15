import Foundation
import SourceKittenFramework

public struct AfferentCouplingMetric: Metric {

    public static let name = "ca"

    let files: [SourceFile]

    public init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var results = [ClassMetricResult]()

        let classes = files.flatMap { ClassFinder($0.structure).find() }

        let classCouplingGraph = ClassCouplingGraphBuilder(classes).build()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let afferentCouplings = ClassAfferentCouplingFinder(className: classStructure.name, classCouplingGraph: classCouplingGraph).find()
                let result = ClassMetricResult(className: classStructure.name, value: Double(afferentCouplings.count), path: file.path)
                results.append(result)
            }
        }

        return results
    }
    
}
