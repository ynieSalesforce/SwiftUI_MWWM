//
//  MapViewSelectable.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/7/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct MapViewSelectable: UIViewRepresentable {
    var viewDidUpdate: ((CLLocationCoordinate2D) -> Void)
    var initialCoordinate: Coordinate
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        updateMapview(mapView, location: initialCoordinate)
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeAnnotations(view.annotations)
        let coordinate = Coordinate.init(lon: Float(view.centerCoordinate.longitude),
                                         lat: Float(view.centerCoordinate.latitude))
        updateMapview(view, location: coordinate)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewSelectable

        init(_ parent: MapViewSelectable) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.viewDidUpdate(mapView.centerCoordinate)
        }
    }
}
