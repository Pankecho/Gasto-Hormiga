//
//  MapTiendaVC.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 15/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapTiendaVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    let autorizacionStatus = CLLocationManager.authorizationStatus()
    
    let regionRadio: Double = 1000.00
    
    var sucursales: [Sucursal]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.locationManager.delegate = self
        configurarServicioLocalizacion()
        for sucursal in self.sucursales{
            let marcador = MKPointAnnotation()
            marcador.title = sucursal.nombre
            marcador.coordinate = CLLocationCoordinate2D(latitude: sucursal.latitud, longitude: sucursal.longitud)
            self.mapView.addAnnotation(marcador)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func centrarPosicion(_ sender: UIButton) {
        centrarMapaEnUbicacion()
    }
}

extension MapTiendaVC: MKMapViewDelegate{
    func centrarMapaEnUbicacion(){
        
        guard let coordenada = locationManager.location?.coordinate else { return }
        
        print(coordenada)

        let coordenadaRegion = MKCoordinateRegionMakeWithDistance(coordenada, regionRadio, regionRadio)
        self.mapView.setRegion(coordenadaRegion, animated: true)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
}

extension MapTiendaVC: CLLocationManagerDelegate{
    func configurarServicioLocalizacion(){
        if autorizacionStatus == .notDetermined{
            self.locationManager.requestAlwaysAuthorization()
        }else{
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centrarMapaEnUbicacion()
    }
}
