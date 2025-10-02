//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Jordan White on 9/16/25.
//

import UIKit
import MapKit
class MapViewController: UIViewController {

    var mapView: MKMapView!
    var filterSwitch: UISwitch!
    var filterLabel: UILabel!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        mapView.showsCompass = false
        
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanges(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        filterLabel = UILabel()
        filterLabel.text = "Points of Interest"
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterLabel)

        
        filterSwitch = UISwitch()
        filterSwitch.isOn = false
        filterSwitch.addTarget(self, action: #selector(togglePointsOfInterest(_:)), for: .valueChanged)
        filterSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterSwitch)
        
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 12),
            filterLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                    
            filterSwitch.leadingAnchor.constraint(equalTo:filterLabel.trailingAnchor, constant: 8),
            filterSwitch.centerYAnchor.constraint(equalTo: filterLabel.centerYAnchor)
        ])



    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("MapViewController loaded its view.")
    }
    
   // func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, constraint c: CGFloat) -> NSLayoutConstraint
    
    @objc func mapTypeChanges(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func togglePointsOfInterest(_ sender: UISwitch) {
        if sender.isOn {
            mapView.pointOfInterestFilter = .includingAll
        } else {
            mapView.pointOfInterestFilter = .excludingAll
        }
    }
}
