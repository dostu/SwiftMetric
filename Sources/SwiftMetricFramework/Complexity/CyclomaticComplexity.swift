import Foundation
import SourceKittenFramework

public struct CyclomaticComplexity {

    let complexityStatements: Set<StatementKind> = [
        .forEach,
        .if,
        .guard,
        .for,
        .repeatWhile,
        .while,
        .case
    ]

    let structure: StructureDictionary

    init(_ structure: StructureDictionary) {
        self.structure = structure
    }

    func measure() -> Int {
        let complexity = structure.substructure.reduce(0) { complexity, subDict in
            guard let kind = subDict.kind else { return complexity }

            if let declarationKind = SwiftDeclarationKind(rawValue: kind),
                SwiftDeclarationKind.functionKinds().contains(declarationKind) {
                return complexity
            }

            guard let statementKind = StatementKind(rawValue: kind) else {
                return complexity + CyclomaticComplexity(subDict).measure()
            }

            let score = complexityStatements.contains(statementKind) ? 1 : 0
            return complexity + score + CyclomaticComplexity(subDict).measure()
        }
        
        return complexity
    }

}
