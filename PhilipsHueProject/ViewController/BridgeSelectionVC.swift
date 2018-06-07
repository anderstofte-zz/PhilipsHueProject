//
//  BridgeSelectionVC.swift
//  PhilipsHueProject
//
//  Created by ISSD on 01/06/2018.
//  Copyright © 2018 dk.anderstofte. All rights reserved.
//

import UIKit


var selectedBridge: PHBridgeInfo? = nil

class BridgeSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bridges: [PHBridgeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        discoverBridges()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bridges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BridgeCell", for: indexPath)
        
        let bridge = bridges[indexPath.row]
        
        cell.textLabel?.text = bridge.ipAdress
        cell.detailTextLabel?.text = bridge.uniqueID
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedBridge = bridges[indexPath.row]
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        discoverBridges()
    }
    
    func discoverBridges() {
        let options: PHSBridgeDiscoveryOption = .discoveryOptionUPNP
        let bridgeDiscovery = PHSBridgeDiscovery()
        
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        
        
        bridgeDiscovery.search(options) { (result, returnCode) in
            if returnCode == .success  {
                
                self.bridges.removeAll()
                
                for(_, value) in result! {
                    let bridgeInfo = PHBridgeInfo(ipAdress: value.ipAddress, uniqueID: value.uniqueId)
                    self.bridges.append(bridgeInfo)
                }
                
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
                self.tableView.reloadData()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
