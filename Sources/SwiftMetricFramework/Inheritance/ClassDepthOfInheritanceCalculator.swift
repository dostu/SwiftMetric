import Foundation
import SwiftGraph

struct ClassDepthOfInheritanceCalculator {

    let className: String
    let classHierarchyGraph: UnweightedGraph<String>

    init(className: String, classHierarchyGraph: UnweightedGraph<String>) {
        self.className = className
        self.classHierarchyGraph = classHierarchyGraph
    }

    func calculate() -> Int {
        let neighbors = classHierarchyGraph.neighborsForVertex(className)!

        if neighbors.isEmpty {
            return 0
        }

        let depths = neighbors.map { ClassDepthOfInheritanceCalculator(className: $0, classHierarchyGraph: classHierarchyGraph).calculate() }

        return depths.max()! + 1
    }

}
