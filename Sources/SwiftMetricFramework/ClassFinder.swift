import SourceKittenFramework

struct ClassFinder {

    let fileStructure: StructureDictionary

    init(_ fileStructure: StructureDictionary) {
        self.fileStructure = fileStructure
    }

    func find() -> [ClassStructure] {
        return fileStructure.substructure.flatMap { ClassStructure(structure: $0) }
    }
    
}
