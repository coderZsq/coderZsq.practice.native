//
//  WeatherDataManager.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import Foundation

class WeatherDataManager {
    // 创建天气服务实例
    private let weatherService = WeatherService()
    
    // 定义异步任务组方法
    func fetchCastsWithTaskGroup(adcodes: [String]) async throws -> [ForecastInfo] {
        // 使用 TaskGroup 创建异步任务组
        return try await withThrowingTaskGroup(of: WeatherResponse?.self) { group in
            // 存储天气信息
            var forecasts: [ForecastInfo] = []
            // 预分配存储空间
            forecasts.reserveCapacity(adcodes.count)
            // 遍历城市编码
            for adcode in adcodes {
                // 向任务组中添加异步任务
                group.addTask {
                    // 调用天气服务获取天气信息
                    try? await self.weatherService.fetch(adcode: adcode)
                }
            }
            // 遍历异步任务结果
            for try await weatherResponse in group {
                // 判断异步任务是否有返回值
                if let weatherResponse = weatherResponse {
                    // 获取天气信息
                    if var forecast = weatherResponse.forecasts.first {
                        // 判断是否有明天的天气信息
                        if forecast.casts.count > 2 {
                            // 获取明天的天气信息
                            let tomorrowCast = forecast.casts[1]
                            // 将明天的天气信息存储到天气信息实例中
                            forecast.tomorrowCast = tomorrowCast
                        }
                        // 将天气信息实例存储到数组中
                        forecasts.append(forecast)
                    }
                }
            }
            // 根据城市编码进行排序
            forecasts.sort(by: { $0.adcode < $1.adcode })

            // 返回存储天气信息的数组
            return forecasts
        }
    }
}
