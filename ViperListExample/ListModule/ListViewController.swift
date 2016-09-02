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
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getItemsForPage(currentPage)
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh(_:)), forControlEvents: .ValueChanged)
        collectionView.addSubview(refreshControl!)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionViewLayout.itemSize = CGSizeMake(self.view.frame.width - 16, 192)
        
        loadingIndicator.startAnimating()
        navigationItem.title = "Images"
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        currentPage = 1
        presenter?.getItemsForPage(currentPage)
    }
    
    func showItems(newItems: [ListItem], shouldRestart: Bool) {
        if (shouldRestart) {
            items = Array()
            loadingIndicator.stopAnimating()
            collectionView.hidden = false
            refreshControl?.endRefreshing()
        }
        items.appendContentsOf(newItems)
        collectionView.reloadData()
    }
    
    func showError(text: String) {
        loadingLabel.text = text
        loadingIndicator.stopAnimating()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ListItemCell", forIndexPath: indexPath) as! ListItemCell
        cell.populateData(items[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == self.items.count - 1) {
            currentPage += 1
            presenter?.getItemsForPage(currentPage)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        presenter?.listItemClicked(items[indexPath.row])
    }
}