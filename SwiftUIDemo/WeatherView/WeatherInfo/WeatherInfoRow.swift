//
//  WeatherInfoRow.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import SwiftUI

struct WeatherInfoRow: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key)
                .font(.body)
                .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 0))
            Spacer()
            Text(value)
                .font(.body)
                .fontWeight(.bold)
                .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 10))
        }
    }
}

struct WeatherInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoRow(key: "Temp",value: "134")
    }
}
