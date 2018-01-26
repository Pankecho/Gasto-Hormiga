//
//  ListaActualVC.swift
//  Gasto Hormiga
//
//  Created by Juan Pablo Martinez Ruiz on 05/11/17.
//  Copyright © 2017 Juan Pablo Martinez Ruiz. All rights reserved.
//

import UIKit

class ListaActualVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var nombreListaLabel: UILabel!
    @IBOutlet weak var lugarCompraLabel: UILabel!
    @IBOutlet weak var totalListaLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var lista: Lista!
    var before: ListaCompraTVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lista.setObserver(view: self)
        nombreListaLabel.text = lista.nombre
        lugarCompraLabel.text = Utilities.getTipoDeLugar(lugar: lista.lugarCompra)
        totalListaLabel.text = "$\(lista.total)"

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.00
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pickProductoSegue"{
            let view = segue.destination as! PickProductoTVC
            view.lista = self.lista
            view.navigationItem.backBarButtonItem?.title = "\(self.lista.nombre)"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.lista.productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productoListaCell", for: indexPath) as! ProductoListaCell
        
        let p = Array(self.lista.productos.keys)
        
        cell.nombreProductoLabel.text = p[indexPath.row].nombre
        cell.precioProductoLabel.text = "$\(p[indexPath.row].precio[lista.lugarCompra]!)"
        cell.cantidadProductoLabel.text = "\(self.lista.productos[p[indexPath.row]]!)"
        
        cell.listaIndex = Lista.listas.index(of: self.lista)
        cell.producto = p[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            // Delete the row from the data source
            let p = Array(self.lista.productos.keys)
            self.lista.removeElement(p: p[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
         }
     }
    
    @IBAction func unWindToListas(_ sender: UIBarButtonItem) {
        before.update()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindFromPick(segue: UIStoryboardSegue){
    }
    
    func update(){
        totalListaLabel.text = "$\(lista.total)"
    }
    
}
