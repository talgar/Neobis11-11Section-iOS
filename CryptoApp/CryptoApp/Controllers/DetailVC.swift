//
//  ViewController.swift
//  CryptoApp
//
//  Created by admin on 08.12.2020.
//

import UIKit
import Charts
import TinyConstraints

class DetailVC: UIViewController, ChartViewDelegate {

    @IBOutlet weak var cryptoName: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    var info : CryptoInfo?
    var charts : [ChartDataEntry] = []
    
    lazy var lineChartView : LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        
        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setCharts()
        loadCharts()
    }
    
    //MARK:-CRYPTO DETAIL INFO
    func setLabels() {
        cryptoName.text = info?.CoinInfo?.FullName?.description
        marketLabel.text = info?.RAW?.USD?.MKTCAP?.description
        changeLabel.text = info?.DISPLAY?.USD?.VOLUME24HOUR?.description
        volumeLabel.text = info?.DISPLAY?.USD?.CHANGE24HOUR?.description
    }
    
    //MARK:-CHART
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setCharts() {
        view.addSubview(lineChartView)
        lineChartView.bottomToSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
    }
    
    func loadCharts() {
        ServerManager.instance.urlPoints.cryptoName = info?.CoinInfo?.Name?.description
        ServerManager.instance.loadChartsInfo(completion: updateCharts)
    }
    
    func updateCharts(info:Charts) {
        for i in (info.Data!.Data!) {
            let coordX = i.open
            let coordY = i.close
            let value = ChartDataEntry(x: coordX!, y: coordY!)
            charts.append(value)
        }
        charts.sort(by: {$0.x < $1.x})
        setChartsData()
    }
    
    func setChartsData() {
        let set = LineChartDataSet(entries: charts)
        set.drawCirclesEnabled = false
        set.mode = .horizontalBezier
        set.setColor(.white)
        set.lineWidth = 2
        set.fill = Fill(color: .white)
        set.fillAlpha = 0.8
        set.drawFilledEnabled = true
        set.drawHorizontalHighlightIndicatorEnabled  = false
        set.highlightColor = .black
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChartView.data = data
    }
}

