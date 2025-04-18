//
//  ChartsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.

import UIKit

class ChartsVC: UIViewController {
    @IBOutlet weak var chartsTitle: UILabel!
    @IBOutlet weak var chartScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCharts()
    }
    
    func setupCharts() {
        var offsetY: CGFloat = 20
        let chartViews: [UIView] = [createPieChartView(), createBarChartView(), createLineChartView(), createScatterPlotView(), createAreaChartView(), createBubbleChartView(), createColumnChartView(), createHistogramView(), createTreeMapView(), createWaterfallChartView(), createGanttChartView(), createBoxPlotView(), createFunnelChartView(), createGuagesView(), createRadarView(), createBulletChartView(), createFlowChartView(), createHeatMapView(), createCommonPlotsView(), createCandleStickChartView(), createPictoGraphView(), createStackedBarChartView(), createComparisionChartView()]
        
        for chartView in chartViews {
            chartView.frame.origin.y = offsetY
            chartScrollView.addSubview(chartView)
            offsetY += chartView.frame.size.height + 20
        }
        
        chartScrollView.contentSize = CGSize(width: chartScrollView.frame.width, height: offsetY)
    }
    
    private func subviewOutline(chartViewTitle: String, alignTitle: NSTextAlignment) -> UIView {
        let chartView = UIView(frame: CGRect(x: 0, y: 0, width: chartScrollView.frame.width, height: 200))
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: chartView.frame.width - 20, height: 30))
        titleLabel.text = chartViewTitle
        titleLabel.textAlignment = alignTitle
        chartView.addSubview(titleLabel)
        chartView.layer.borderWidth = 1
        chartView.layer.borderColor = UIColor.yellow.cgColor
        return chartView
    }
}

// MARK: - Pie Chart
extension ChartsVC {
    func createPieChartView() -> UIView {
        let pieChartView = self.subviewOutline(chartViewTitle: "Pie Chart", alignTitle: .left)
        let radius = (pieChartView.bounds.height - 60) / 2
        let center = CGPoint(x: pieChartView.bounds.width / 2, y: pieChartView.bounds.height / 2)
        let dataPoints: [CGFloat] = [30, 20, 50, 40, 10, 5]
        let totalValue = dataPoints.reduce(0, +)
        var startAngle: CGFloat = -CGFloat.pi / 2
        
        for (index, value) in dataPoints.enumerated() {
            let endAngle = startAngle + (CGFloat.pi * 2 * (value / totalValue))
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: center)
            path.close()
            
            let sliceLayer = CAShapeLayer()
            sliceLayer.path = path.cgPath
            sliceLayer.fillColor = UIColor.random.cgColor
            sliceLayer.strokeColor = UIColor.white.cgColor
            sliceLayer.lineWidth = 1
            pieChartView.layer.addSublayer(sliceLayer)
            
            let midAngle = startAngle + (endAngle - startAngle) / 2
            let labelX = center.x + (radius + 20) * cos(midAngle)
            let labelY = center.y + (radius + 20) * sin(midAngle)
            let valueLabel = UILabel(frame: CGRect(x: labelX - 20, y: labelY - 10, width: 40, height: 20))
            valueLabel.text = "\(Int(value))"
            valueLabel.textAlignment = .center
            pieChartView.addSubview(valueLabel)
            startAngle = endAngle
        }
        return pieChartView
    }
}

// MARK: - Bar Chart
extension ChartsVC {
    func createBarChartView() -> UIView {
        let barChartView = self.subviewOutline(chartViewTitle: "Bar Chart", alignTitle: .center)
        let dataPoints: [CGFloat] = [50, 100, 75, 150, 125, 200]
        let maxValue = dataPoints.max() ?? 1
        let barWidth = (barChartView.frame.width - CGFloat(dataPoints.count - 1) * 10) / CGFloat(dataPoints.count)

        for (index, value) in dataPoints.enumerated() {
            let barHeight = (value / maxValue) * (barChartView.frame.height - 50)
            let barX = CGFloat(index) * (barWidth + 10)
            let barY = barChartView.frame.height - barHeight - 40
            let barView = UIView(frame: CGRect(x: barX, y: barY, width: barWidth, height: barHeight))
            barView.backgroundColor = UIColor.random
            barChartView.addSubview(barView)
        }
        return barChartView
    }
}

// MARK: - Line Chart
extension ChartsVC {
    func createLineChartView() -> UIView {
        let lineChartView = self.subviewOutline(chartViewTitle: "Line Chart", alignTitle: .center)
        
        let xLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let xLabelWidth = lineChartView.frame.width / CGFloat(xLabels.count)
        for (index, labelText) in xLabels.enumerated() {
            let label = UILabel(frame: CGRect(x: CGFloat(index) * xLabelWidth, y: lineChartView.frame.height - 20, width: xLabelWidth, height: 20))
            label.text = labelText
            label.textAlignment = .center
            label.backgroundColor = UIColor.lightGray
            lineChartView.addSubview(label)
        }
        
        let yLabels = ["0", "50", "100", "150", "200"]
        let yLabelHeight = (lineChartView.frame.height - 50) / CGFloat(yLabels.count)
        for (index, labelText) in yLabels.enumerated() {
            let label = UILabel(frame: CGRect(x: 0, y: lineChartView.frame.height - CGFloat(index + 1) * yLabelHeight - 20, width: 30, height: 20))
            label.text = labelText
            label.textAlignment = .right
            label.font = UIFont.systemFont(ofSize: 10)
            label.backgroundColor = UIColor.lightGray
            lineChartView.addSubview(label)
        }
        
        let dataPoints: [CGFloat] = [50, 100, 75, 150, 125, 200]
        let maxValue = dataPoints.max() ?? 1
        let barWidth = (lineChartView.frame.width - CGFloat(dataPoints.count - 1) * 10) / CGFloat(dataPoints.count)
        var previousPoint: CGPoint?
        for (index, value) in dataPoints.enumerated() {
            let barHeight = (value / maxValue) * (lineChartView.frame.height - 50)
            let barX = CGFloat(index) * (barWidth + 10)
            let barY = lineChartView.frame.height - barHeight - 40
            let barView = UIView(frame: CGRect(x: barX, y: barY, width: barWidth, height: 2))
            barView.backgroundColor = UIColor.random
            lineChartView.addSubview(barView)
            
            if let previousPoint = previousPoint {
                let path = UIBezierPath()
                path.move(to: previousPoint)
                path.addLine(to: CGPoint(x: barX + barWidth / 2, y: barY + 1))
                let lineLayer = CAShapeLayer()
                lineLayer.path = path.cgPath
                lineLayer.strokeColor = UIColor.random.cgColor
                lineLayer.lineWidth = 2
                lineChartView.layer.addSublayer(lineLayer)
            }
            previousPoint = CGPoint(x: barX + barWidth / 2, y: barY + 1)
        }
        return lineChartView
    }
}

// MARK: - Scatter Plot
extension ChartsVC {
    func createScatterPlotView() -> UIView {
        let scatterPlotView = self.subviewOutline(chartViewTitle: "Scatter Plot", alignTitle: .center)
    
        let xAxis = UIView(frame: CGRect(x: 0, y: scatterPlotView.bounds.height, width: scatterPlotView.bounds.width - 40, height: 1))
        xAxis.backgroundColor = .white
        scatterPlotView.addSubview(xAxis)
        
        let yAxis = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: scatterPlotView.bounds.height - 40))
        yAxis.backgroundColor = .white
        scatterPlotView.addSubview(yAxis)
        
        let numberOfPoints = 20
        let scatterPlotWidth = scatterPlotView.bounds.width - 40
        let scatterPlotHeight = scatterPlotView.bounds.height - 40
        
        for _ in 0..<numberOfPoints {
            let x = CGFloat.random(in: 0..<scatterPlotWidth)
            let y = CGFloat.random(in: 0..<scatterPlotHeight)
            
            let circleView = UIView(frame: CGRect(x: x + 20, y: scatterPlotView.bounds.height - y - 40, width: 5, height: 5))
            circleView.backgroundColor = UIColor.random
            circleView.layer.cornerRadius = 2.5
            scatterPlotView.addSubview(circleView)
            
            let label = UILabel(frame: CGRect(x: x + 15, y: scatterPlotView.bounds.height - y - 50, width: 30, height: 20))
            label.text = "(\(Int(x)), \(Int(y)))"
            label.font = UIFont.systemFont(ofSize: 10)
            label.textAlignment = .center
            scatterPlotView.addSubview(label)
        }
        return scatterPlotView
    }
}

// MARK: - Area Chart
extension ChartsVC {
    func createAreaChartView() -> UIView {
        let areaChartView = self.subviewOutline(chartViewTitle: "Area Chart", alignTitle: .center)
        let dataPoints: [CGFloat] = [50, 100, 75, 150, 125, 200]
        let maxValue = dataPoints.max() ?? 1
        let plotWidth = areaChartView.frame.width - 40
        let plotHeight = areaChartView.frame.height - 40
        
        // Draw x-axis
        let xAxis = UIView(frame: CGRect(x: 20, y: plotHeight, width: plotWidth, height: 1))
        xAxis.backgroundColor = .white
        areaChartView.addSubview(xAxis)
        
        // Draw y-axis
        let yAxis = UIView(frame: CGRect(x: 20, y: 0, width: 1, height: plotHeight))
        yAxis.backgroundColor = .white
        areaChartView.addSubview(yAxis)
        
        let path = UIBezierPath()
        for (index, value) in dataPoints.enumerated() {
            let xPos = CGFloat(index) * (plotWidth / CGFloat(dataPoints.count - 1)) + 20
            let yPos = plotHeight - (value / maxValue) * plotHeight
            
            if index == 0 {
                path.move(to: CGPoint(x: xPos, y: yPos))
            } else {
                path.addLine(to: CGPoint(x: xPos, y: yPos))
            }
            
            let circleView = UIView(frame: CGRect(x: xPos - 2.5, y: yPos - 2.5, width: 5, height: 5))
            circleView.backgroundColor = .red
            circleView.layer.cornerRadius = 2.5
            areaChartView.addSubview(circleView)
        }
        
        path.addLine(to: CGPoint(x: plotWidth + 20, y: plotHeight))
        path.addLine(to: CGPoint(x: 20, y: plotHeight))
        path.close()
        
        let areaLayer = CAShapeLayer()
        areaLayer.path = path.cgPath
        areaLayer.fillColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        areaChartView.layer.addSublayer(areaLayer)
        
        return areaChartView
    }
}

// MARK: - Bubble Plot
extension ChartsVC {
    func createBubbleChartView() -> UIView {
        let bubbleChartView = self.subviewOutline(chartViewTitle: "Bubble Plot", alignTitle: .center)
        let dataPoints: [(x: CGFloat, y: CGFloat, size: CGFloat)] = [(50, 100, 20), (100, 150, 30), (150, 200, 40), (200, 250, 50), (250, 300, 60)]
        let maxX = dataPoints.map { $0.x }.max() ?? 1
        let maxY = dataPoints.map { $0.y }.max() ?? 1
        let maxBubbleSize = dataPoints.map { $0.size }.max() ?? 1
        let plotWidth = bubbleChartView.frame.width - 40
        let plotHeight = bubbleChartView.frame.height - 40
        
        // Draw x-axis
        let xAxis = UIView(frame: CGRect(x: 20, y: plotHeight, width: plotWidth, height: 1))
        xAxis.backgroundColor = .white
        bubbleChartView.addSubview(xAxis)
        
        // Draw y-axis
        let yAxis = UIView(frame: CGRect(x: 20, y: 0, width: 1, height: plotHeight))
        yAxis.backgroundColor = .white
        bubbleChartView.addSubview(yAxis)
        
        for dataPoint in dataPoints {
            let xPos = 20 + (dataPoint.x / maxX) * plotWidth
            let yPos = plotHeight - (dataPoint.y / maxY) * plotHeight
            
            let bubbleSize = (dataPoint.size / maxBubbleSize) * 50
            
            let bubbleView = UIView(frame: CGRect(x: xPos - bubbleSize / 2, y: yPos - bubbleSize / 2, width: bubbleSize, height: bubbleSize))
            bubbleView.backgroundColor = UIColor.random.withAlphaComponent(0.5)
            bubbleView.layer.cornerRadius = bubbleSize / 2
            bubbleChartView.addSubview(bubbleView)
        }
        return bubbleChartView
    }
}

// MARK: - Column Chart
extension ChartsVC {
    func createColumnChartView() -> UIView {
        let columnChartView = self.subviewOutline(chartViewTitle: "Column Chart", alignTitle: .center)
        return columnChartView
    }
}

// MARK: - Histogram
extension ChartsVC {
    func createHistogramView() -> UIView {
        let histogramView = self.subviewOutline(chartViewTitle: "Histogram", alignTitle: .center)
        return histogramView
    }
}

// MARK: - TreeMap
extension ChartsVC {
    func createTreeMapView() -> UIView {
        let treeMapView = self.subviewOutline(chartViewTitle: "TreeMap", alignTitle: .center)
        return treeMapView
    }
}

// MARK: - Waterfall Chart
extension ChartsVC {
    func createWaterfallChartView() -> UIView {
        let waterfallChartView = self.subviewOutline(chartViewTitle: "Waterfall Chart", alignTitle: .center)
        return waterfallChartView
    }
}

// MARK: - Gantt Chart
extension ChartsVC {
    func createGanttChartView() -> UIView {
        let ganttChartView = self.subviewOutline(chartViewTitle: "Gantt Chart", alignTitle: .center)
        return ganttChartView
    }
}

// MARK: - Box Plot
extension ChartsVC {
    func createBoxPlotView() -> UIView {
        let boxPlotView = self.subviewOutline(chartViewTitle: "Box Plot", alignTitle: .center)
        return boxPlotView
    }
}

// MARK: - Funnel Chart
extension ChartsVC {
    func createFunnelChartView() -> UIView {
        let funnelChartView = self.subviewOutline(chartViewTitle: "Funnel Chart", alignTitle: .center)
        return funnelChartView
    }
}

// MARK: - Guages
extension ChartsVC {
    func createGuagesView() -> UIView {
        let guagesView = self.subviewOutline(chartViewTitle: "Guages", alignTitle: .center)
        return guagesView
    }
}

// MARK: - Radar
extension ChartsVC {
    func createRadarView() -> UIView {
        let radarView = self.subviewOutline(chartViewTitle: "Radar", alignTitle: .center)
        return radarView
    }
}

// MARK: - Bullet Chart
extension ChartsVC {
    func createBulletChartView() -> UIView {
        let bulletChartView = self.subviewOutline(chartViewTitle: "Bullet Chart", alignTitle: .center)
        return bulletChartView
    }
}

// MARK: - Flow Chart
extension ChartsVC {
    func createFlowChartView() -> UIView {
        let flowChartView = self.subviewOutline(chartViewTitle: "Flow Chart", alignTitle: .center)
        return flowChartView
    }
}

// MARK: - Heat Map
extension ChartsVC {
    func createHeatMapView() -> UIView {
        let heatMapView = self.subviewOutline(chartViewTitle: "Heat Map", alignTitle: .center)
        return heatMapView
    }
}

// MARK: - Common Plots
extension ChartsVC {
    func createCommonPlotsView() -> UIView {
        let commonPlotsView = self.subviewOutline(chartViewTitle: "Common Plots", alignTitle: .center)
        return commonPlotsView
    }
}

// MARK: - Candle Stick Chart
extension ChartsVC {
    func createCandleStickChartView() -> UIView {
        let candelStickChartView = self.subviewOutline(chartViewTitle: "Candle Stick Chart", alignTitle: .center)
        return candelStickChartView
    }
}

// MARK: - Picto Graph
extension ChartsVC {
    func createPictoGraphView() -> UIView {
        let pictoGraphView = self.subviewOutline(chartViewTitle: "Picto Graph", alignTitle: .center)
        return pictoGraphView
    }
}

// MARK: - Stacked Bar Chart
extension ChartsVC {
    func createStackedBarChartView() -> UIView {
        let stackedChartView = self.subviewOutline(chartViewTitle: "Stacked Bar Chart", alignTitle: .center)
        return stackedChartView
    }
}

// MARK: - Comparision Chart
extension ChartsVC {
    func createComparisionChartView() -> UIView {
        let comparisionChartView = self.subviewOutline(chartViewTitle: "Comparision Chart", alignTitle: .center)
        return comparisionChartView
    }
}

// MARK: - Generate Random Colors
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
