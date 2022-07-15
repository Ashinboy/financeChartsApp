//
//  chartDetailViewController.swift
//  financeChartsApp
//
//  Created by Ashin Wang on 2022/6/9.
//

import UIKit
import Charts

class chartDetailViewController: UIViewController {

    
    //Top
    @IBOutlet weak var stockNameText: UILabel!
    @IBOutlet weak var stockNumText: UILabel!
    
    
    //MovingAverage
    
    
    
    //Footer
    @IBOutlet weak var currentPeText: UILabel!
    @IBOutlet weak var currentPbText: UILabel!
    
    @IBOutlet weak var yearPeAverageText: UILabel!
    @IBOutlet weak var yearPbAverageText: UILabel!
    
    @IBOutlet weak var sameIndustryPeMidianText: UILabel!
    @IBOutlet weak var sameIndustryPbMidianText: UILabel!
    
    //Data
    var stockItems: StockData?
    var stockDatas: String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       fetchStockData()
    }
    
   
    
    
    func fetchStockData(){
        let urlString = "write your api here"
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                    if let data = data {
                        do {
                            let stockResponse = try! decoder.decode(StockData.self, from: data)
                            self.stockItems = stockResponse
                            
                            DispatchQueue.main.async {
                                self.stockNameText.text = self.stockItems?.data[0]?.股票名稱
                                self.currentPbText.text = self.stockItems?.data[0]?.目前本淨比.description
                                self.currentPeText.text = self.stockItems?.data[0]?.目前本益比.description
                                self.yearPeAverageText.text = "21.42"
                                self.yearPbAverageText.text = "5.17"
                                self.sameIndustryPeMidianText.text = self.stockItems?.data[0]?.同業本益比中位數.description
                                self.sameIndustryPbMidianText.text = self.stockItems?.data[0]?.同業本淨比中位數.description
                            }
                        } catch  {
                            print("傳送失敗")
                        }
                    }else{
                        print("error")
                    }
                }.resume()
            }
        }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
