import Foundation
import SourceKittenFramework
import SwiftGraph

public struct ClassSeparateComponentsCalculator {

    let classStructure: ClassStructure
    let file: SourceFile

    init(_ classStructure: ClassStructure, file: SourceFile) {
        self.classStructure = classStructure
        self.file = file
    }

    func calculate() -> Int {
        let variables = ClassVariableFinder(classStructure.body).find()
        let methods = MethodFinder(classStructure.body).find()

        let methodMemberAccesses = methods.map { method -> MethodMembersAccess in
            let variableAccess = VariableAccessFinder(methodStructure: method, variables: variables, file: file).find()
            let methodInvocations = MethodInvocationFinder(methodStructure: method, methods: methods).find()
            return MethodMembersAccess(methodStructure: method, variables: variableAccess, methods: methodInvocations)
        }

        let graph = UnweightedGraph<String>(vertices: methods.map { $0.nameWithoutParams })

        for methodA in methodMemberAccesses {
            for methodB in methodMemberAccesses {
                let methodAName = methodA.methodStructure.nameWithoutParams
                let methodBName = methodB.methodStructure.nameWithoutParams
                guard methodAName != methodBName else { continue }

                let usedVariables = methodA.variables.intersection(methodB.variables)

                if !usedVariables.isEmpty || methodA.methods.contains(methodBName) {
                    graph.addEdge(from: methodAName, to: methodBName)
                }
            }
        }

        return GraphComponentCounter(graph).count()
    }
    
}
