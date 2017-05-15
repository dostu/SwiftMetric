import Foundation

struct ClassEfferentCouplingFinder {

    let standardTypes = ["Double", "String"]

    let classStructure: ClassStructure

    init(_ classStructure: ClassStructure) {
        self.classStructure = classStructure
    }

    func find() -> Set<String> {
        var results = Set<String>()

        let variables = ClassVariableFinder(classStructure.body).find()
        let methods = MethodFinder(classStructure.body).find()

        for variable in variables {
            guard let variableType = variable.type else { continue }
            results.insert(variableType)
        }

        for method in methods {
            let coupledClasses = MethodCoupledClassesFinder(methodStructure: method.structure).find()

            coupledClasses.forEach { results.insert($0) }
        }

        return results.subtracting(standardTypes)
    }

}
