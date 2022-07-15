//
//  chartsViewController.swift
//  financeChartsApp
//
//  Created by Ashin Wang on 2022/6/13.
//

import UIKit
import Charts
import SwiftUI


class chartsViewController: UIViewController , ChartViewDelegate{
    
 
    var stockInfo = [MovingAverageDetail]()
    
    
    //Charts
    lazy var lineChart: LineChartView = {
        let chartView = LineChartView()
        
        chartView.backgroundColor = .clear
        let yAxis = chartView.leftAxis
        //left & right
        chartView.rightAxis.enabled = false
        yAxis.setLabelCount(5, force: true)
        yAxis.labelFont = .systemFont(ofSize: 10)
        yAxis.labelTextColor = .lightGray
        //x
        chartView.xAxis.setLabelCount(6, force: true)
        chartView.xAxis.labelTextColor = .lightGray
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .systemFont(ofSize: 10)
        stockInfo.reverse()
        chartView.xAxis.valueFormatter =  ChartXAxisFormatter(stockDetail: stockInfo)
        chartView.animate(xAxisDuration: 2.5)
        
        return chartView
    }()
    
    
    
    //Date
    var monthLine: String = ""
    var monthInfo: [String] = []
    
    var resultDate: Double = 0
    var time: String = ""
    
    
    
    //Price
    var stocksPrice: String = ""
    var stockPrice: [String] = []
    
    //Average
    var averageBenchMark: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchStockDatas()
    }
    
    
    override func viewDidLayoutSubviews() {
        
    }
   
    

    

    //Data
    func fetchStockDatas(){
        let urlString = "write your api here"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let stockResponse = try! decoder.decode(stockDetailData.self, from: data)
                        self.stockInfo = stockResponse.data.first?.河流圖資料!.filter({ data in
                            data.averagePrice != nil
                        }) ?? []
                        print("checkkkkStockInfo",self.stockInfo)
                        DispatchQueue.main.async {
                            self.updateGraph()
                            

                        }
                    } catch {
                        print("傳送失敗")
                    }
                }else{
                    print("error")
                }
            }.resume()
        }
    }
    
    
    func updateGraph(){
        var chartsValue = [ChartDataEntry]()
        //setLineChartFrame
        self.lineChart.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(self.lineChart)
        self.lineChart.center = self.view.center
        
        //noData
        self.lineChart.noDataText = "You need to provide data for the chart."
        
        //X.Y info
        
        for i in stockInfo.indices{
            let set1Data = ChartDataEntry(
                x: Double(i),
                y: Double(self.stockInfo[i].averagePrice!))

            
            chartsValue.append(set1Data)


        }
        

        //MonthAverageLine
        let set1 = LineChartDataSet(entries: chartsValue, label: "月均線")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.lineWidth = 3
        set1.setColor(.white)
        
        set1.colors = ChartColorTemplates.material()
        let Linedata = LineChartData(dataSet: set1)
        
        lineChart.data = Linedata
        
        //set2
        
        
    }
    
    
    class ChartXAxisFormatter: NSObject, AxisValueFormatter {

        var stockDetail: [MovingAverageDetail]
    
        init(stockDetail: [MovingAverageDetail]) {
            self.stockDetail = stockDetail
        }
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            let index = Int(value)
            var time = stockDetail[index].time
            time.insert("/", at: time.index(time.startIndex, offsetBy: 4))
            return time

        }
    }
}

