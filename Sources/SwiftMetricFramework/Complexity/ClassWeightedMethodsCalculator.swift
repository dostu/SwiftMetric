import Foundation
import SourceKittenFramework

public struct ClassWeightedMethodsCalculator {

    let classStructure: ClassStructure

    init(_ classStructure: ClassStructure) {
        self.classStructure = classStructure
    }

    func calculate() -> Int {
        let methods = MethodFinder(classStructure.body).find()

        let methodWeights = methods.map { CyclomaticComplexity($0.structure).measure() + 1 }

        return methodWeights.reduce(0, +)
    }

}
