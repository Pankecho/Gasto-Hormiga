//
//  ListaCompraTVC.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 05/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListaCompraTVC: UITableViewController {
    
    var listas: [Lista]!

    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.getCategorias()
        Utilities.getEstablecimientos()
        listas = Lista.listas
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Utilities.isInternetAvailable(){
            let controller = UIAlertController(title: "Sin conexión a Internet", message: "Esta aplicación requiere una conexión a internet", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            controller.addAction(ok)
            controller.addAction(cancel)
            
            present(controller, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listaCompraCell", for: indexPath) as! ListaComprasCell
        
        cell.nombreListaLabel.text = listas[indexPath.row].nombre!
        cell.lugarCompraLabel.text = Utilities.getTipoDeLugar(lugar: listas[indexPath.row].lugarCompra!)
        cell.totalListaCell.text = "$\(listas[indexPath.row].total)"

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Lista.listas.remove(at: indexPath.row)
            self.listas = Lista.listas
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showLista" {
            let index = tableView.indexPathForSelectedRow!
            let destino = segue.destination as! UINavigationController
            let view = destino.topViewController as! ListaActualVC
            view.lista = listas[index.row]
            view.before = self
        }
    }
    
    @IBAction func addListaComprasPressed(_ sender: UIBarButtonItem) {
        var tipo: String!
        let alerta: UIAlertController = UIAlertController(title: "Lugar donde haces las compras", message: nil, preferredStyle: .actionSheet)
        let mercado: UIAlertAction = UIAlertAction(title: "Mercado", style: .default) { (u) in
            tipo = "mercado"
            self.askForName(tipo: tipo)
        }
        let mercado_ambu: UIAlertAction = UIAlertAction(title: "Mercado ambulante", style: .default) { (u) in
            tipo = "mercado_ambulante"
            self.askForName(tipo: tipo)
        }
        let tianguis: UIAlertAction = UIAlertAction(title: "Tianguis", style: .default) { (u) in
            tipo = "tianguis"
            self.askForName(tipo: tipo)
        }
        let auto: UIAlertAction = UIAlertAction(title: "Autoservicio", style: .default) { (u) in
            tipo = "tienda_autoservicio"
            self.askForName(tipo: tipo)
        }
        let cancel: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction(mercado)
        alerta.addAction(mercado_ambu)
        alerta.addAction(tianguis)
        alerta.addAction(auto)
        alerta.addAction(cancel)
        
        present(alerta, animated: true, completion: nil)
    }
    
    func askForName(tipo: String!){
        var nombre: String!
        let alerta: UIAlertController = UIAlertController(title: "Nueva lista", message: nil, preferredStyle: .alert)
        let confirm: UIAlertAction = UIAlertAction(title: "Agregar", style: .default) { (_) in
            if let field = alerta.textFields?[0]{
                
                nombre = field.text!
                Lista.listas.append(Lista(nombre: nombre, lugar: tipo))
                self.listas = Lista.listas
                self.update()
            }else{
                nombre = "Lista \(tipo)"
            }
        }
        alerta.addTextField { (t) in
            t.placeholder = "Nombre"
        }
        alerta.addAction(confirm)
        
        present(alerta, animated: true, completion: nil)
    }
    
    func update(){
        tableView.reloadData()
    }
}
