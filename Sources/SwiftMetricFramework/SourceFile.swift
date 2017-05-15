import SourceKittenFramework

public struct SourceFile {

    public let path: String
    public let content: String

    public init(path: String, content: String) {
        self.path = path
        self.content = content
    }

    var structure: StructureDictionary {
        return sourceKittenFile.structure.dictionary
    }

    var syntaxMap: SyntaxMap {
        return sourceKittenFile.syntaxMap
    }

    var syntaxTokensByLines: [[SyntaxToken]] {
        return sourceKittenFile.syntaxTokensByLines
    }

    private var sourceKittenFile: File {
        return File(contents: content)
    }

}
