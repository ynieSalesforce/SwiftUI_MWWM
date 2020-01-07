//
//  MapContainerView.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/6/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    var delegate: MapDelegate
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = delegate
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let mockCoordinate = CLLocationCoordinate2D.init(latitude: 37.91531, longitude: -75.383212)
        let region = MKCoordinateRegion(center: mockCoordinate, span: span)
        uiView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mockCoordinate
        annotation.title = "Chincoteague"
        uiView.addAnnotation(annotation)
    }
    
}

class MapDelegate: NSObject, MKMapViewDelegate {
    private var updateAction: ((CLLocationCoordinate2D) -> Void)
    init(updateAction: @escaping ((CLLocationCoordinate2D) -> Void)) {
        self.updateAction = updateAction
        super.init()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.centerCoordinate
        self.updateAction(coordinate)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(delegate: MapDelegate.init(updateAction: { coordinate in
            
        }))
    }
}
