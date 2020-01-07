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
    var delegate: MapDelegate?
    var location: Coordinate?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = delegate
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        guard let location = location else { return }
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let coordinate = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(location.lat), longitude: CLLocationDegrees(location.lon))
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
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
