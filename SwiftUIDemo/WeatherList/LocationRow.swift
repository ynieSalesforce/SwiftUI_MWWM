//
//  Locationrow.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/6/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import SwiftUI

struct LocationRow: View {
    var location: Location
    
    var body: some View {
        HStack {
            Text(location.name)
            Spacer()
            
            
        }
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        LocationRow(location: .init(id: "hash", name: "Test", coordinate: .init(lon: 20, lat: 20), zipcode: "20001"))
    }
}
