//
//  WeatherView.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import SwiftUI

struct WeatherView: View {
    
    let info: ForecastInfo
    
    init(info: ForecastInfo) {
        self.info = info
    }
    
    var body: some View {
        content
    }
}

extension WeatherView {
    private var content: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .frame(maxWidth: .infinity)
                    .shadow(color: Color(UIColor.secondarySystemBackground).opacity(0.3), radius: 10, x: -20, y: -20)
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(info.city)")
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text("(\(info.adcode))")
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    .padding(.trailing, 10)
                    if let tomorrowCast = info.tomorrowCast {
                        HStack {
                            Text("日期: \(tomorrowCast.date)")
                            Text("星期\(map(tomorrowCast.week))")
                        }
                        HStack {
                            Text("天气: \(trans(tomorrowCast.dayweather, "转", tomorrowCast.nightweather))")
                            Text("温度: \(trans(tomorrowCast.nighttemp, "-", tomorrowCast.daytemp)) 度")
                        }
                        HStack {
                            Text("风向: \(trans(tomorrowCast.daywind, "-", tomorrowCast.nightwind))")
                            Text("风力: \(trans(tomorrowCast.daypower, "-", tomorrowCast.nightpower))")
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension WeatherView {
    
    /// 星期几的转换函数
    func map(_ week: String) -> String {
        return [
            "1": "一",
            "2": "二",
            "3": "三",
            "4": "四",
            "5": "五",
            "6": "六",
            "7": "天"
        ][week] ?? ""
    }
    
    /// 天气信息的转换函数
    func trans(_ first: String, _ mid: String, _ last: String) -> String {
        if first == last {
            return first
        }
        return "\(first)\(mid)\(last)"
    }
}
