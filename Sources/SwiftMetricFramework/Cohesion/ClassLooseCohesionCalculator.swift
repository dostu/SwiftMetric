import Foundation
import SourceKittenFramework
import SwiftGraph

struct ClassLooseCohesionCalculator {

    let classStructure: ClassStructure
    let file: SourceFile

    init(_ classStructure: ClassStructure, file: SourceFile) {
        self.classStructure = classStructure
        self.file = file
    }

    func calculate() -> Double {
        let variables = ClassVariableFinder(classStructure.body).find()
        let methods = MethodFinder(classStructure.body).find()
        let publicMethods = methods.filter { [.public, .internal].contains($0.accessibilityKind!) }

        let members = variables.map { $0.name } + methods.map { $0.nameWithoutParams }
        let graph = UnweightedGraph<String>(vertices: members)

        for method in methods {
            let variableAccess = VariableAccessFinder(methodStructure: method, variables: variables, file: file).find()
            let methodInvocations = MethodInvocationFinder(methodStructure: method, methods: methods).find()

            for accessedVariable in variableAccess {
                graph.addEdge(from: method.nameWithoutParams, to: accessedVariable)
            }

            for invocedMethod in methodInvocations {
                graph.addEdge(from: method.nameWithoutParams, to: invocedMethod, directed: true)
            }
        }

        let variableAccessGraph = UnweightedGraph(vertices: members)

        for method in methods {
            for variable in variables {
                if !graph.dfs(from: method.nameWithoutParams, to: variable.name).isEmpty {
                    variableAccessGraph.addEdge(from: method.nameWithoutParams, to: variable.name)
                }
            }
        }

        var connectedMethodPairs = Set<MethodPair>()

        for methodA in methods {
            for methodB in methods {
                guard methodA.nameWithoutParams != methodB.nameWithoutParams else { continue }

                let variablesAccessedByMethodA = variableAccessGraph.neighborsForVertex(methodA.nameWithoutParams)!
                let variablesAccessedByMethodB = variableAccessGraph.neighborsForVertex(methodB.nameWithoutParams)!
                let variablesAccessedByBoth = Set(variablesAccessedByMethodA).intersection(variablesAccessedByMethodB)

                if !variablesAccessedByBoth.isEmpty {
                    let methodPair = MethodPair(methodA: methodA.nameWithoutParams, methodB: methodB.nameWithoutParams)
                    connectedMethodPairs.insert(methodPair)
                }
            }
        }

        let methodConnectionGraph = UnweightedGraph<String>(vertices: methods.map { $0.nameWithoutParams })

        for pair in connectedMethodPairs {
            methodConnectionGraph.addEdge(from: pair.methodA, to: pair.methodB)
        }

        var indirectlyConnectedMethods = Set<MethodPair>()

        for methodA in publicMethods {
            for methodB in publicMethods {
                guard methodA.nameWithoutParams != methodB.nameWithoutParams else { continue }
                let path = methodConnectionGraph.dfs(from: methodA.nameWithoutParams, to: methodB.nameWithoutParams)
                if !path.isEmpty {
                    let pair = MethodPair(methodA: methodA.nameWithoutParams, methodB: methodB.nameWithoutParams)
                    indirectlyConnectedMethods.insert(pair)
                }
            }
        }

        let possibleConnectionsCount = publicMethods.count * (publicMethods.count - 1) / 2

        guard possibleConnectionsCount > 0 else {
            return 0
        }

        let result = Double(indirectlyConnectedMethods.count) / Double(possibleConnectionsCount)
        
        assert(result <= 1)
        
        return result
    }
    
}
