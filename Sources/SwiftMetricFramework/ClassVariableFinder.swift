import Foundation
import SourceKittenFramework

public struct ClassVariableFinder {

    let classBody: [StructureDictionary]

    init(_ classBody: [StructureDictionary]) {
        self.classBody = classBody
    }

    func find() -> [VariableStructure] {
        return classBody.flatMap { VariableStructure(structure: $0) }
    }
    
}
