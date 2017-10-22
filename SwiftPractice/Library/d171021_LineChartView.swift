//
//  d171021_.swift
//  SwiftPractice
//
//  Created by yuki takei on 2017/10/21.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

/*
 - [danielgindi/Charts: Beautiful charts for iOS/tvOS/OSX! The Apple side of the crossplatform MPAndroidChart.](https://github.com/danielgindi/Charts)
 
 - [[Swift] [iOS] チャート表示ライブラリ [ios-charts] 詳細な使い方 - Qiita](https://qiita.com/touyu/items/9b77647cf7c97362da10)
 - [[Swift] [iOS] チャート表示ライブラリ [ios-charts] 軸に関する設定 - Qiita](https://qiita.com/touyu/items/b4011e260cc22d0af8d5)
 - [【Swift】Chartsを使って色々なグラフを描画してみる - しめ鯖日記](http://llcc.hatenablog.com/entry/2016/12/19/234222)
 - [LineChartExample/ViewController.swift at master · osianSmith/LineChartExample](https://github.com/osianSmith/LineChartExample/blob/master/LineChartExample/ViewController.swift)

 - [Gradient Fill in Swift for iOS-Charts - Stack Overflow](https://stackoverflow.com/questions/35133314/gradient-fill-in-swift-for-ios-charts)

 
*/

import UIKit
import Charts

class d171021_LineChartView: UIViewController {
    
    var lineChartView:LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        setupLineChartView()
        setupData()
       
    }

    
    func setupLineChartView(){
        let lineChartView:LineChartView = LineChartView()
        lineChartView.frame = self.view.frame
        self.view.addSubview(lineChartView)
        
        self.lineChartView = lineChartView
    }

    
    func setupData(){
        
        var lineChartEntry  = [ChartDataEntry]()
        for i in 1...20 {
            let chartData = ChartDataEntry(x: Double(i), y: Double(arc4random_uniform(UInt32(i))*2))
            lineChartEntry.append(chartData)
        }
        
        let gradientColors = [UIColor.blue.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        
        let line = LineChartDataSet(values: lineChartEntry, label: "test")
//        line.colors = [NSUIColor.black]
        line.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        line.drawFilledEnabled = true
        line.mode = .horizontalBezier
        
        let data = LineChartData()
        data.addDataSet(line)
    
        lineChartView.data = data
        lineChartView.chartDescription?.text = "Hello!"
    }
    

}
