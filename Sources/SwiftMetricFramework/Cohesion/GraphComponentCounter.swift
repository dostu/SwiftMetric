import Foundation
import SwiftGraph

class GraphComponentCounter {

    let graph: UnweightedGraph<String>

    private var visited = Set<String>()

    init(_ graph: UnweightedGraph<String>) {
        self.graph = graph
    }

    func count() -> Int {
        visited.removeAll()

        var components = 0

        for vertex in graph.immutableVertices {
            guard !visited.contains(vertex) else { continue }

            visited.insert(vertex)
            components += 1

            depthFirstSearch(vertex)
        }

        return components
    }

    func depthFirstSearch(_ node: String) {
        for vertex in graph.neighborsForVertex(node)! {
            guard !visited.contains(vertex) else { continue }

            visited.insert(vertex)
            depthFirstSearch(vertex)
        }
    }

}
