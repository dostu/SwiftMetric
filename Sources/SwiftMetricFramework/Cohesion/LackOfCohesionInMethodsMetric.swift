import Foundation
import SourceKittenFramework

public class LackOfCohesionInMethodsMetric: Metric {

    public static var name = "lcom"

    let files: [SourceFile]

    public required init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var results = [ClassMetricResult]()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let classResult = ClassSeparateComponentsCalculator(classStructure, file: file).calculate()
                let result = ClassMetricResult(className: classStructure.name, value: Double(classResult), path: file.path)
                results.append(result)
            }
        }

        return results
    }
    
}
