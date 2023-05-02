//
//  AmapWeatherService.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import Foundation
import Alamofire

class WeatherService {
    
    // Web服务 API Key
    private let key = "330af4e8cbd76a55e6afe4e0a8530c48"
    
    /// 异步请求天气信息
    func fetch(adcode: String) async throws -> WeatherResponse {
        do {
            // 使用 AF 请求库发送网络请求并反序列化返回的 JSON 数据到 WeatherResponse 对象中
            return try await AF.request("https://restapi.amap.com/v3/weather/weatherInfo?key=\(key)&city=\(adcode)&extensions=all")
                .serializingDecodable(WeatherResponse.self).value
        } catch {
            // 如果请求失败，则抛出错误
            throw error
        }
    }
}
