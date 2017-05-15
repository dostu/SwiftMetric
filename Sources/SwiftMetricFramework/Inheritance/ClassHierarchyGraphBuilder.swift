import Foundation
import SwiftGraph

struct ClassHierarchyGraphBuilder {

    let classes: [ClassStructure]
    let reverseDirection: Bool

    init(_ classes: [ClassStructure], reverseDirection: Bool = false) {
        self.classes = classes
        self.reverseDirection = reverseDirection
    }

    func build() -> UnweightedGraph<String> {
        let graph = UnweightedGraph<String>(vertices: classes.map { $0.name })

        for classStructure in classes {
            guard let parent = classStructure.parent else { continue }
            let child = classStructure.name

            if reverseDirection {
                graph.addEdge(from: child, to: parent, directed: true)
            } else {
                graph.addEdge(from: parent, to: child, directed: true)
            }
        }

        return graph
    }

}
