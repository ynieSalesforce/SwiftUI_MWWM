//
//  MapContainerView.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/6/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import SwiftUI

struct MapContainerView: View {
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    
    var mapDelegate: MapDelegate
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select your location")
                .font(.title)
                .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 10))
            HStack {
                Text("Please select your desired location")
                    .font(.caption)
                    .padding(20)
                Spacer()
                Button.init("Select") {
                    self.presentationMode.wrappedValue.dismiss()
                }.padding(20).font(.caption)
            }
            MapView(delegate: mapDelegate)
        }
    }
}

struct MapContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerView(mapDelegate: .init(updateAction: { location in
            
        }))
    }
}
