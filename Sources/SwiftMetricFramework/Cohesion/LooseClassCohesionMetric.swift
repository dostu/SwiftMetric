import Foundation
import SourceKittenFramework

public class LooseClassCohesionMetric: Metric {

    public static var name = "lcc"

    let files: [SourceFile]

    public required init(_ files: [SourceFile]) {
        self.files = files
    }

    public func measure() -> [ClassMetricResult] {
        var results = [ClassMetricResult]()

        for file in files {
            let classes = ClassFinder(file.structure).find()

            for classStructure in classes {
                let lcc = ClassLooseCohesionCalculator(classStructure, file: file).calculate()
                let result = ClassMetricResult(className: classStructure.name, value: lcc, path: file.path)
                results.append(result)
            }
        }

        return results
    }
    
}
