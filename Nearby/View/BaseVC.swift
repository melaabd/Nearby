//
//  BaseVC.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import UIKit


/// Binding delegate to connect between VC and VM
protocol BindingVVMDelegate: AnyObject {
    func reloadData()
    func notifyFailure(msg: String)
}

// MARK: - BaseVC that have comman properties and functions for othe view controllers
class BaseVC: UIViewController, BindingVVMDelegate {

    
    var baseVM:BaseViewModel? {
        didSet {
            baseVM?.bindingDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Conform with BaseVC Binding Protocol
    
    /// reload data delegate that will be called in sub views
    func reloadData() { }
    
    /// show alert for user in case something went wrong
    /// - Parameter msg: alert message
    func notifyFailure(msg: String) {
        onMain { [weak self] in
            let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
            alert.addAction(dismissAction)
            self?.present(alert, animated: true)
        }
    }

}
