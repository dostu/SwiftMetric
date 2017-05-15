import Foundation
import SwiftGraph

struct ClassAfferentCouplingFinder {

    let className: String
    let classCouplingGraph: UnweightedGraph<String>

    init(className: String, classCouplingGraph: UnweightedGraph<String>) {
        self.className = className
        self.classCouplingGraph = classCouplingGraph
    }

    func find() -> Set<String> {
        let neighbors = classCouplingGraph.neighborsForVertex(className)!
        return Set(neighbors)
    }
    
}
