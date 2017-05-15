import Foundation
import SourceKittenFramework

struct VariableAccessFinder {

    let methodStructure: MethodStructure
    let variables: [VariableStructure]
    let file: SourceFile

    init(methodStructure: MethodStructure, variables: [VariableStructure], file: SourceFile) {
        self.methodStructure = methodStructure
        self.variables = variables
        self.file = file
    }

    func find() -> Set<String> {
        var results = Set<String>()

        let contents = file.content.bridge()

        for variable in variables {
            let regex = try! NSRegularExpression(pattern: variable.name,
                                                 options: [.ignoreMetacharacters])

            let rangeStart = methodStructure.structure.offset!
            let rangeLength = methodStructure.structure.length!
            let range = contents.byteRangeToNSRange(start: rangeStart, length: rangeLength)!

            let matches = regex.matches(in: file.content, options: [], range: range).ranges()

            for range in matches {
                if let byteRange = contents.NSRangeToByteRange(start: range.location,
                                                               length: range.length)
                {
                    let tokens = file.syntaxMap.tokens(inByteRange: byteRange)

                    if let token = tokens.first, SyntaxKind(rawValue: token.type) == .identifier,
                        token.offset == byteRange.location, token.length == byteRange.length {

                        results.insert(variable.name)
                    }
                }
            }
        }

        return results
    }

}
