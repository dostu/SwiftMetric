import Foundation
import Commandant

let registry = CommandRegistry<SwiftMetricError>()
let measureCommand = MeasureCommand()
registry.register(measureCommand)
registry.register(HelpCommand(registry: registry))

registry.main(defaultVerb: measureCommand.verb) { error in
    fputs(error.description + "\n", stderr)
}
