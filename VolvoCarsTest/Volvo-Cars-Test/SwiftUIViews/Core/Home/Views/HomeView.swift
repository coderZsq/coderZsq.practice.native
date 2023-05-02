//
//  HomeView.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBarView(searchText: $vm.searchAdcode)
                    ScrollView {
                        LazyVStack {
                            ForEach(vm.list, id: \.self) { info in
                                WeatherView(info: info)
                                    .frame(height: 100)
                                    .frame(maxWidth: .infinity)
                                    .padding(.leading, 18)
                                    .padding(.trailing, 18)
                            }
                        }
                    }
                    .navigationTitle("明日天气")
                }
                if (vm.isFetching) {
                    ProgressView()
                }
            }
        }
    }
}
