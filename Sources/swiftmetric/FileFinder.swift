import Foundation
import Files
import SwiftMetricFramework

struct FileFinder {

    let paths: [String]

    func find() -> [SourceFile] {
        var filePaths = Set<String>()

        var pathsToSearch = paths

        if paths.isEmpty {
            pathsToSearch.append(Folder.current.path)
        }

        for path in pathsToSearch {
            if fileExists(atPath: path) {
                filePaths.insert(path)
            } else {
                let files = findFilesInFolder(atPath: path)
                filePaths = filePaths.union(files)
            }
        }

        return filePaths.flatMap { buildSourceFile(path: $0) }
    }

    func fileExists(atPath path: String) -> Bool {
        guard let file = try? File(path: path) else { return false }
        return isSwiftFile(file)
    }

    func findFilesInFolder(atPath path: String) -> [String] {
        guard let folder = try? Folder(path: path) else { return [] }
        let files = folder.makeFileSequence(recursive: true).filter { isSwiftFile($0) }
        return files.map { $0.path }
    }

    func isSwiftFile(_ file: File) -> Bool {
        return file.extension == "swift"
    }

    func buildSourceFile(path: String) -> SourceFile? {
        do {
            let file = try File(path: path)
            let content = try file.readAsString()
            return SourceFile(path: file.path, content: content)
        } catch {
            return nil
        }
    }

}
