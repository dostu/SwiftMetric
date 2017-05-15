import Foundation
import SwiftGraph

struct ClassNumberOfChildrenCalculator {

    let className: String
    let classHierarchyGraph: UnweightedGraph<String>

    init(className: String, classHierarchyGraph: UnweightedGraph<String>) {
        self.className = className
        self.classHierarchyGraph = classHierarchyGraph
    }

    func calculate() -> Int {
        let neighbors = classHierarchyGraph.neighborsForVertex(className)!
        return neighbors.count
    }
    
}
