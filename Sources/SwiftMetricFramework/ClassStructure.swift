import SourceKittenFramework

struct ClassStructure {

    let name: String
    let structure: StructureDictionary

    var parent: String? {
        return structure.inheritedTypes.first
    }

    var body: [StructureDictionary] {
        return structure.substructure
    }

    init?(structure: StructureDictionary) {
        guard let kind = structure.kind else { return nil }
        guard let declarationKind = SwiftDeclarationKind(rawValue: kind) else { return nil }
        guard SwiftDeclarationKind.typeKinds().contains(declarationKind) || declarationKind == .protocol else { return nil }
        guard let name = structure.name else { return nil }

        self.name = name
        self.structure = structure
    }

}
