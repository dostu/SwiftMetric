import Foundation
import SwiftGraph

struct ClassCouplingGraphBuilder {

    let classes: [ClassStructure]

    init(_ classes: [ClassStructure]) {
        self.classes = classes
    }

    func build() -> UnweightedGraph<String> {
        let graph = UnweightedGraph<String>(vertices: classes.map { $0.name })

        for classStructure in classes {
            let efferentCouplings = ClassEfferentCouplingFinder(classStructure).find()

            for coupledClass in efferentCouplings {
                graph.addEdge(from: coupledClass, to: classStructure.name, directed: true)
            }
        }
        
        return graph
    }
    
}
