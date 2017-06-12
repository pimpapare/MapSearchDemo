//
//  SearchListViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import IGListKit

class SearchListViewController: BaseViewController {
    
    @IBOutlet weak var txUserSelectedLocation: UILabel!
    @IBOutlet weak var vHeader: UIView!
    
    var observer : NSObjectProtocol!
    
    lazy var mapViewModel:MapViewModel! = MapViewModel(delegate: self)
    lazy var searchViewModel:SearchViewModel = SearchViewModel(delegate: self)
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var collectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserve()
    }
    
    func addObserve(){
        
        observer = NotificationCenter.default.addObserver(forName: .updateCell, object: nil, queue: OperationQueue.main) { n in
            
            self.txUserSelectedLocation.text = String(format: "From Latitude: %2f, Longitude: %2f",self.mapViewModel.getUserSelectedLocation().0, self.mapViewModel.getUserSelectedLocation().1)
            self.setCollectionView()
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    override public func refrashCollectionView() {
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    func setCollectionView() {
        
        collectionView = UICollectionView(frame:CGRect(x:0,y:50,width: Constant.DEVICE_W, height: Constant.DEVICE_H-170), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(collectionView!)
        
        adapter.collectionView = collectionView
        
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
}

extension SearchListViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.searchViewModel.map
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SearchSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let nibView = Bundle.main.loadNibNamed("EmptyView", owner: nil, options: nil)!.first as! EmptyView
        return nibView
    }
}

extension SearchListViewController: UIScrollViewDelegate{
    
    func didReload() {
        adapter.performUpdates(animated: true, completion: nil)
    }
}
