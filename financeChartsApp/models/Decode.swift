//
//  Decode.swift
//  financeChartsApp
//
//  Created by Ashin Wang on 2022/6/11.
//

import Foundation

func decodeJsonData<T: Decodable>(_ data: Data) -> T{
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError()
    }
}






