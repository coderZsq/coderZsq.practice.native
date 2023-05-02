//
//  WeatherResponse.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import Foundation

struct WeatherResponse: Codable {
    /// 返回状态
    let status: String
    /// 返回结果总数目
    let count: String
    /// 返回的状态信息
    let info: String
    /// 返回状态说明,10000代表正确
    let infocode: String
    /// 预报天气信息数据
    let forecasts: [ForecastInfo]
}

struct ForecastInfo: Codable, Hashable {
    /// 城市名称
    let city: String
    /// 城市编码
    let adcode: String
    /// 省份名称
    let province: String
    /// 预报发布时间
    let reporttime: String
    /// 预报数据list结构，元素cast,按顺序为当天、第二天、第三天的预报数据
    let casts: [CastInfo]
    /// 明天的预报数据
    var tomorrowCast: CastInfo?
    
    static func == (lhs: ForecastInfo, rhs: ForecastInfo) -> Bool {
        lhs.city == rhs.city
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }
}

struct CastInfo: Codable {
    /// 日期
    let date: String
    /// 星期几
    let week: String
    /// 白天天气现象
    let dayweather: String
    /// 晚上天气现象
    let nightweather: String
    /// 白天温度
    let daytemp: String
    /// 晚上温度
    let nighttemp: String
    /// 白天风向
    let daywind: String
    /// 晚上风向
    let nightwind: String
    /// 白天风力
    let daypower: String
    /// 晚上风力
    let nightpower: String
}
