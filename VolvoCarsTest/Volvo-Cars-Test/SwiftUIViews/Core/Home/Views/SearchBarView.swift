//
//  SearchBarView.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.secondary : Color.black
                )
            TextField("请输入城市编码", text: $searchText)
                .foregroundColor(Color.secondary)
                .disableAutocorrection(true)
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:  10)
                        .foregroundColor(Color.secondary)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.1))
                .shadow(
                    color: Color.secondary.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        )
        .padding(.leading, 14)
        .padding(.trailing, 14)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
