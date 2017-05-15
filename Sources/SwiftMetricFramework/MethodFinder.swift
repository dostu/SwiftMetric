import SourceKittenFramework

struct MethodFinder {

    let classBody: [StructureDictionary]

    init(_ classBody: [StructureDictionary]) {
        self.classBody = classBody
    }

    func find() -> [MethodStructure] {
        return classBody.flatMap { MethodStructure(structure: $0) }
    }

}
