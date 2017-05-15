import Foundation
import SourceKittenFramework

public class TightClassCohesionMetric: Metric {

    public static var name = "tcc"

    let files: [SourceFile]

    public required init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var results = [ClassMetricResult]()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let classResult = ClassTightCohesionCalculator(classStructure, file: file).calculate()
                let result = ClassMetricResult(className: classStructure.name, value: classResult, path: file.path)
                results.append(result)
            }
        }

        return results
    }
    
}
