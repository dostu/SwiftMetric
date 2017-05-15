import Foundation
import SourceKittenFramework

extension SyntaxKind {
    /// Returns if the syntax kind is comment-like.
    public var isCommentLike: Bool {
        return [
            SyntaxKind.comment,
            .commentMark,
            .commentURL,
            .docComment,
            .docCommentField
            ].contains(self)
    }
}

struct ClassLinesOfCodeCalculator {

    private let classStructure: ClassStructure
    private let file: SourceFile

    init(_ classStructure: ClassStructure, file: SourceFile) {
        self.classStructure = classStructure
        self.file = file
    }

    func calculate() -> Int {
        let structure = classStructure.structure
        let offset = structure.bodyOffset!
        let length = structure.bodyLength!

        let fileContents = file.content.bridge()

        let startLine = fileContents.lineAndCharacter(forByteOffset: offset)!.line
        let endLine = fileContents.lineAndCharacter(forByteOffset: offset + length)!.line

        let lines = file.syntaxTokensByLines[startLine...endLine]

        let nonCommentLines = lines.filter { tokens in
            let nonCommentTokens = tokens.filter { token in
                guard let kind = SyntaxKind(rawValue: token.type) else { return false }
                return !kind.isCommentLike
            }

            return !nonCommentTokens.isEmpty
        }

        return nonCommentLines.count
    }

}
