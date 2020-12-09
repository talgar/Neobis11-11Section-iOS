//
//  CryptoListVC.swift
//  CryptoApp
//
//  Created by admin on 08.12.2020.
//

import UIKit

class CryptoListVC: UITableViewController {

    @IBOutlet var tablleView: UITableView!
    
    var crypto : Crypto?
    var cryptoInfo : [CryptoInfo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCrypto()
    }

    func loadCrypto() {
        ServerManager.instance.loadCryptoInfo(completion: updateCrypto)
    }
    
    func updateCrypto(info:Crypto) {
        for i in (info.Data!) {
            cryptoInfo.append(i)
            tablleView.reloadData()
        }
        print(cryptoInfo)
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cryptoInfo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoTableViewCell
        
        if cryptoInfo.isEmpty {
            return cell
        }
        
        let info = cryptoInfo[indexPath.row]
        
        cell.cryptoImage.image = UIImage(named: (info.CoinInfo?.Name!.description)!)
        cell.nameLabel.text = info.CoinInfo?.FullName?.description
        cell.internalLabel.text = info.CoinInfo?.Internal?.description
        cell.priceLabel.text = info.DISPLAY?.USD?.PRICE?.description
        cell.changeLabel.text = ((info.RAW?.USD?.CHANGEPCT24HOUR?.roundedCrypto(digits: 2).description)!)+"%"
        
        if ((info.RAW?.USD?.CHANGEPCT24HOUR)!) > 0 {
            cell.changeLabel.textColor = .green
        } else {
            cell.changeLabel.textColor = .red
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension Double {
    func roundedCrypto(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

