import Foundation
import SourceKittenFramework

public struct ResponseForClassCalculator {

    let classStructure: ClassStructure

    init(_ classStructure: ClassStructure) {
        self.classStructure = classStructure
    }

    func calculate() -> Int {
        let methods = MethodFinder(classStructure.body).find()

        var allMethodsCalled = Set<String>()

        for method in methods {
            let methodsCalled = findMethodCalls(method.body)

            for methodCalled in methodsCalled {
                allMethodsCalled.insert(methodCalled)
            }
        }

        return methods.count + allMethodsCalled.count
    }

    func findMethodCalls(_ structure: [StructureDictionary]) -> Set<String> {
        var methods = Set<String>()

        for subDict in structure {
            let calledMethods = findMethodCalls(subDict.substructure)

            for calledMethod in calledMethods {
                methods.insert(calledMethod)
            }

            guard let kind = subDict.kind else { continue }
            guard let expressionKind = SwiftExpressionKind(rawValue: kind) else { continue }
            guard expressionKind == .call else { continue }
            guard let name = subDict.name else { continue }

            let methodName = name.components(separatedBy: ".").last!
            methods.insert(methodName)
        }

        return methods
    }

}
