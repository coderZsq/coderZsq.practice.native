//
//  HomeViewModel.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // 默认城市编码列表
    let defaultAdcodes = [
        "110000", // 北京
        "310000", // 上海
        "440100", // 广州
        "440300", // 深圳
        "320500", // 苏州
        "210100"  // 沈阳
    ]
    
    // 天气数据管理对象
    private let manager = WeatherDataManager()
    // 订阅的集合
    private var cancellables = Set<AnyCancellable>()

    /// 是否正在请求中
    var isFetching: Bool = true
    
    /// 搜索城市编码
    @Published var searchAdcode: String = ""
    /// 接口请求全量的预报
    @Published var allCasts: [ForecastInfo] = []
    /// 前端展示的预报
    @Published var list: [ForecastInfo] = []

    // 使用 async/await 异步获取城市预报
    func getCastsWith(adcodes: [String]) async {
        if let casts = try? await manager.fetchCastsWithTaskGroup(adcodes: adcodes) {
            // 切回主线程更新 UI
            await MainActor.run {
                self.allCasts = casts
                self.list.append(contentsOf: casts)
                self.isFetching = false
            }
        }
    }
    
    init() {
        addSubscriber()
    }

    // 添加搜索城市编码订阅
    func addSubscriber() {
        $searchAdcode
            .combineLatest(self.$allCasts)
            // 防抖处理，防止频繁搜索
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filter)
            .sink { [weak self] (list) in
                self?.list = list
            }
            .store(in: &cancellables)
    }

    /// 前缀过滤，用于搜索预报信息
    private func filter(adcode: String, infos: [ForecastInfo]) -> [ForecastInfo] {
        var forecastInfos = [ForecastInfo]()
        for info in infos {
            if info.adcode.hasPrefix(adcode) {
                forecastInfos.append(info)
            }
        }
        return forecastInfos
    }
}
