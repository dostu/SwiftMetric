import Foundation
import SourceKittenFramework

struct MethodStructure {

    let name: String
    let structure: StructureDictionary

    var body: [StructureDictionary] {
        return structure.substructure
    }

    var nameWithoutParams: String {
        let regex = try! NSRegularExpression(pattern: "^\\w+", options: [])
        let nsString = name as NSString
        let matches = regex.matches(in: name, options: [], range: NSMakeRange(0, nsString.length))
        guard let match = matches.first else { return name }
        let nameWithoutParams = nsString.substring(with: match.range)
        return nameWithoutParams
    }

    var accessibilityKind: SwiftAccessibilityKind? {
        guard let accessibility = structure.accessibility else { return nil }
        return SwiftAccessibilityKind(rawValue: accessibility)
    }

    init?(structure: StructureDictionary) {
        guard let kind = structure.kind else { return nil }
        guard let declarationKind = SwiftDeclarationKind(rawValue: kind) else { return nil }
        guard SwiftDeclarationKind.functionKinds().contains(declarationKind) else { return nil }
        guard let name = structure.name else { return nil }

        self.name = name
        self.structure = structure
    }

}
