import Foundation
import SourceKittenFramework

struct MethodCoupledClassesFinder {

    let methodStructure: StructureDictionary

    func find() -> [String] {
        var classes = Set<String>()

        for subDict in methodStructure.substructure {
            let substructureClasses = MethodCoupledClassesFinder(methodStructure: subDict).find()

            for clazz in substructureClasses {
                classes.insert(clazz)
            }

            if let kind = subDict.kind {
                if let declarationKind = SwiftDeclarationKind(rawValue: kind) {
                    if declarationKind == .varParameter {
                        if let typeName = subDict.typeName {
                            classes.insert(typeName)
                        }
                    }
                }
            }

            guard let kind = subDict.kind else { continue }
            guard let expressionKind = SwiftExpressionKind(rawValue: kind) else { continue }
            guard expressionKind == .call else { continue }
            guard let name = subDict.name else { continue }

            let regex = try! NSRegularExpression(pattern: "^[A-Z]\\w*", options: [])
            let nsString = name as NSString
            let matches = regex.matches(in: name, options: [], range: NSMakeRange(0, nsString.length))

            guard !matches.isEmpty else { continue }

            let match = matches.first!
            let realName = nsString.substring(with: match.range)
            classes.insert(realName)
        }

        return Array(classes)
    }

}
