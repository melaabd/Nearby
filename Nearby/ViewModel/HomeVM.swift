//
//  HomeVM.swift
//  Nearby
//
//  Created by melaabd on 1/13/22.
//

import Foundation


class HomeVM: BaseViewModel {
    
    
    required init(places: [VAnnotation]?) {
        super.init()
        
        annotations = places
        bindingDelegate?.reloadData()
    }
}
