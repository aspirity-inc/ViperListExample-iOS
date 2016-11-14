//
//  DetailsViewController.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailsViewController : UIViewController, DetailsViewInterface {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    var presenter: DetailsPresenterInterface?
    let cache = ContainerManager.manager.container.resolve(AutoPurgingImageCache.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        presenter?.updateView()
    }
    
    func showData(_ url: String?, title: String?) {
        self.navigationItem.title = title
        if url == nil {
            self.loadingIndicator.stopAnimating()
            return
        }
        Alamofire.request(url!, method: .get).responseImage { response in
            if let image = response.result.value {
                self.imageView.image = image
                self.cache?.add(image, withIdentifier: url!)
                self.loadingIndicator.stopAnimating()
                self.imageView.isHidden = false
            }
        }
    }
    
    func showError(_ text: String?) {
        loadingIndicator.stopAnimating()
        loadingLabel.text = text
    }
}
