import Foundation
import SourceKittenFramework

public struct NumberOfChildrenMetric: Metric {

    public static let name = "noc"

    let files: [SourceFile]

    public init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var results = [ClassMetricResult]()

        let classes = files.flatMap { ClassFinder($0.structure).find() }
        let classHierarchyGraph = ClassHierarchyGraphBuilder(classes).build()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let depth = ClassNumberOfChildrenCalculator(className: classStructure.name, classHierarchyGraph: classHierarchyGraph).calculate()
                let result = ClassMetricResult(className: classStructure.name, value: Double(depth), path: file.path)
                results.append(result)
            }
        }

        return results
    }

}
