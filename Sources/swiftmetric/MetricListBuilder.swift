import Foundation
import SwiftMetricFramework

struct MetricListBuilder {

    let metrics: [String]

    let availableMetrics: [Metric.Type] = [
        EfferentCouplingMetric.self,
        AfferentCouplingMetric.self,
        CouplingBetweenObjectClassesMetric.self,
        LackOfCohesionInMethodsMetric.self,
        TightClassCohesionMetric.self,
        LooseClassCohesionMetric.self,
        DepthOfInhetiranceTreeMetric.self,
        NumberOfChildrenMetric.self,
        WeightedMethodsPerClassMetric.self,
        ResponseForClassMetric.self,
        LinesOfCodeMetric.self,
    ]

    func build() throws -> [Metric.Type] {
        guard !metrics.isEmpty else {
            return availableMetrics
        }

        let metricTypes = try metrics.map { metric -> Metric.Type in
            guard let metricType = findMetric(metric) else {
                throw SwiftMetricError.unknownMetric
            }

            return metricType
        }

        return metricTypes
    }

    func findMetric(_ metric: String) -> Metric.Type? {
        let metricType = availableMetrics.first { $0.name == metric }
        return metricType
    }

}
