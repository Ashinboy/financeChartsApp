//
//  codable.swift
//  financeChartsApp
//
//  Created by Ashin Wang on 2022/6/11.
//

import Foundation


struct StockData: Codable{
    var data: [Data?]
    struct Data: Codable{
        var 股票代號: String
        var 股票名稱: String
        var 本益比基準: [String]
        var 本淨比基準: [String]
        var 河流圖資料: [MovingAverageDetail]?
        
        struct MovingAverageDetail: Codable{
            var 年月: String
            var 月平均收盤價: String
            var 近四季EPS: String
            var 月近四季本益比: String
            var 本益比股價基準: [String]
            var 近一季BPS: String
            var 月近一季本淨比: String
            var 本淨比股價基準: [String]?
            var 平均本益比: String?
            var 平均本淨比: String?
            var 近3年年複合成長: String?
            
        }
        var 目前本益比: String
        var 目前本淨比: String
        var 同業本益比中位數: String
        var 同業本淨比中位數: String
        var 本益比股價評估: String
        var 本淨比股價評估: String
        var 平均本益比: String?
        var 平均本淨比: String?
        var 本益成長比: String
    }
}




//decodable
struct stockDetailData: Decodable{
    let data: [Data]
    
    struct Data: Decodable{
        let 股票代號: String?
        let 股票名稱: String?
        var 河流圖資料: [MovingAverageDetail]?
        
        enum codingKeys: String, CodingKey{
            case 河流圖資料 = "河流圖資料"
        }
        
    }
    
    
    let 目前本益比: String?
    let 目前本淨比: String?
    let 同業本益比中位數: String?
    let 同業本淨比中位數: String?
}



struct MovingAverageDetail: Decodable{
    let time: String
    let averagePrice: Double?
    
    enum codingKeys: String , CodingKey{
        case time = "年月"
        case averagePrice = "月平均收盤價"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        if let monthString = try? container.decode(String.self, forKey: .averagePrice ),
           let month = Double(monthString){
            self.averagePrice = month
        }else{
            self.averagePrice = nil
        }
        self.time = try container.decode(String.self, forKey: .time)
    }
}

