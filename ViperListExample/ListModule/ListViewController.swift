//
//  ListViewController.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import UIKit
import Swinject

class ListViewController: UIViewController, ListViewInterface, UICollectionViewDataSource, UICollectionViewDelegate {
        
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    var refreshControl: UIRefreshControl?
    
    var presenter: ListPresenterInterface?
    var items: [ListItem] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMoreItems()
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl!)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionViewLayout.itemSize = CGSize(width: self.view.frame.width - 16, height: 192)
        
        loadingIndicator.startAnimating()
        navigationItem.title = "Images"
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        presenter?.refresh()
    }
    
    func showItems(_ newItems: [ListItem], shouldRestart: Bool) {
        if (shouldRestart) {
            items = Array()
            loadingIndicator.stopAnimating()
            collectionView.isHidden = false
            refreshControl?.endRefreshing()
        }
        items.append(contentsOf: newItems)
        collectionView.reloadData()
    }
    
    func showError(_ text: String) {
        loadingLabel.text = text
        loadingIndicator.stopAnimating()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListItemCell", for: indexPath) as! ListItemCell
        cell.populateData(items[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if ((indexPath as NSIndexPath).row == self.items.count - 1) {
            presenter?.getMoreItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.listItemClicked(items[(indexPath as NSIndexPath).row])
    }
}
