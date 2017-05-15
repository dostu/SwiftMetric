import Foundation
import SourceKittenFramework

struct MethodInvocationFinder {

    let methodStructure: MethodStructure
    let methods: [MethodStructure]

    init(methodStructure: MethodStructure, methods: [MethodStructure]) {
        self.methodStructure = methodStructure
        self.methods = methods
    }

    func find() -> Set<String> {
        var results = Set<String>()

        let methodNames = methods.map { $0.nameWithoutParams }

        for subDict in methodStructure.structure.substructure {
            guard let kind = subDict.kind else { continue }
            guard let expressionKind = SwiftExpressionKind(rawValue: kind) else { continue }
            guard expressionKind == .call else { continue }
            guard let name = subDict.name else { continue }
            guard methodNames.contains(name) else { continue }

            results.insert(name)
        }

        return results
    }
    
}
