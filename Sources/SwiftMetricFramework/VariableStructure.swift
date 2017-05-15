import Foundation
import SourceKittenFramework

struct VariableStructure {

    let name: String
    let structure: StructureDictionary

    var body: [StructureDictionary] {
        return structure.substructure
    }

    init?(structure: StructureDictionary) {
        guard let kind = structure.kind else { return nil }
        guard let declarationKind = SwiftDeclarationKind(rawValue: kind) else { return nil }
        guard SwiftDeclarationKind.variableKinds().contains(declarationKind) else { return nil }
        guard let name = structure.name else { return nil }

        self.name = name
        self.structure = structure
    }

    var type: String? {
        return structure.typeName
    }
    
}
