public struct MetricResultsCalculator {

    let files: [SourceFile]
    let metrics: [Metric.Type]

    public init(files: [SourceFile], metrics: [Metric.Type]) {
        self.files = files
        self.metrics = metrics
    }

    public func calculate() -> [String: [ClassMetricResult]] {
        var results = [String: [ClassMetricResult]]()

        for metric in metrics {
            results[metric.name] = metric.init(files).measure()
        }

        return results
    }

}
