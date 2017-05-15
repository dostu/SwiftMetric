public enum SwiftMetricError: Error {
    case unknownFormat
    case unknownPath
    case unknownMetric
}

extension SwiftMetricError {

    var description: String {
        switch self {
        case .unknownFormat:
            return "Unknown format"
        case .unknownPath:
            return "Unknown path"
        case .unknownMetric:
            return "Unknown metric"
        }
    }

}
