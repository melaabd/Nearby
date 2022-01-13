//
//  LaunchScreen.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import UIKit

class LaunchVC: BaseVC {
    
    @IBOutlet weak var gifImageView: UIImageView?
    var launchVM:LaunchVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGifImage()
        launchVM = LaunchVM()
        baseVM = launchVM
        LocationManager.shared.getUserLocation { [weak self] loc in
            self?.launchVM?.loadVenues(lat: loc.coordinate.latitude, long: loc.coordinate.longitude, radius: 2000)
        }
    }
    
    /// set waiting gif image
    private func setGifImage() {
        guard let bundle = Bundle.main.url(forResource: "searching", withExtension: "gif"), let imageData = try? Data(contentsOf: bundle) else { return }
        gifImageView?.image = UIImage.gifImageWithData(imageData)
    }
    
    /// set root view controller
    func setRootVC() {
        onMain { [weak self] in
            let story = UIStoryboard(name: "Main", bundle:nil)
            guard let vc = story.instantiateViewController(withIdentifier: String(describing: HomeVC.self)) as? HomeVC else { return }
            vc.homeVM = HomeVM(places: self?.launchVM?.annotations)
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    override func reloadData() {
        onMain { [weak self] in
            self?.gifImageView?.stopAnimating()
            self?.gifImageView = nil
            self?.setRootVC()
        }
    }
}
