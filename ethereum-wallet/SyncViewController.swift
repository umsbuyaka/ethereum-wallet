//
//  SyncViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 27/04/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController {
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Ethereum.core.syncDelegate = self
        
        Global {
            Ethereum.core.start()
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
    }

}

// MARK: - WalletServiceDelegate

extension SyncViewController: EthereumCoreSyncDelegate {
    func syncFinished() {
        progressLabel.text = "Finished!"
    }
    
    func syncProgressDidChange(current: Int64, total: Int64) {
        activityIndicator.stopAnimating()
        let progress = Float(current) / Float(total)
        progressView.setProgress(progress, animated: true)
        progressLabel.text = "\(current)/\(total)"
    }

    
    func didReceiveBlock(_ number: Int64) {
    }
    
    func didFailed(with error: Error) {
        error.showAllertIfNeeded(from: self)
    }
    
}