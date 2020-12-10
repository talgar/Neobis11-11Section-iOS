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
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoTableViewCell
        cell.selectionStyle = .none
        
        if cryptoInfo.isEmpty {
            return cell
        }
        
        let info = cryptoInfo[indexPath.row]
        
        cell.cryptoImage.image = UIImage(named: (info.CoinInfo?.Name!.description)!)
        cell.nameLabel.text = info.CoinInfo?.FullName?.description
        cell.internalLabel.text = info.CoinInfo?.Internal?.description
        cell.priceLabel.text = info.DISPLAY?.USD?.PRICE?.description
        cell.changeLabel.text = ((info.RAW?.USD?.CHANGEPCT24HOUR?.roundedCrypto(digits: 2).description)!)+"%"
        
        if ((info.RAW?.USD?.CHANGEPCT24HOUR)!) >= 0 {
            cell.changeLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell.upDownImage.image = UIImage(named: "up")
        } else {
            cell.changeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.upDownImage.image = UIImage(named: "down")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = cryptoInfo[indexPath.row]
        performSegue(withIdentifier: "DetailVC", sender: info)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            let detVC = segue.destination as! DetailVC
            detVC.info = (sender as! CryptoInfo)
        }
    }
}


