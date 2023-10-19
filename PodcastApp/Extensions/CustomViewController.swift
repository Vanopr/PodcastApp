//
//  CustomViewController.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import UIKit

class CustomViewController<V: CustomView>: UIViewController {
    
    override func loadView() {
        view = V()
    }
    
    // To access view use this computed property
    var customView: V {
        view as! V
    }
}
