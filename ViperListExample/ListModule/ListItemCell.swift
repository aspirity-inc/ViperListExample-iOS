//
//  ListItemCell.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ListItemCell : UICollectionViewCell {
    
    var item: ListItem?
    let cache = ContainerManager.manager.container.resolve(AutoPurgingImageCache.self)
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 0.6
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = true
    }
    
    func populateData(_ item: ListItem) {
        self.item = item
        cellImage.image = nil
        cellTitle.text = item.title
        let image = cache?.imageWithIdentifier(item.thumbnailUrl!)
        if image != nil {
            cellImage.image = image
            return
        } else {
            loadImage(item.thumbnailUrl!)
        }
    }
    
    func loadImage(_ url: String) {
        Alamofire.request(.GET, url).responseImage { response in
            if let image = response.result.value {
                if (self.item?.thumbnailUrl == url) { //this is to prevent showing images in wrong cells
                    self.cellImage.image = image
                }
                self.cache?.addImage(image, withIdentifier: url)
            }
        }
    }
}
