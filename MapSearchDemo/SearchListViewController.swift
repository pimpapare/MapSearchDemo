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
    
    var observer : NSObjectProtocol!

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    lazy var mapViewModel:MapViewModel = MapViewModel(delegate: self)
    //:MovieViewModelProtocol = MovieViewModel(delegate: self)
    
    var collectionView:UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserve()
        setCollectionView()
    }
    
    func addObserve(){
        
        observer = NotificationCenter.default.addObserver(forName: .updateCell, object: nil, queue: OperationQueue.main) { n in
            print("mapViewModel ",self.mapViewModel.getPlacesLocationLatLng(at: 0, key: "lat"))
            self.refrashCollectionView()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView?.frame = CGRect(x:0,y: self.mapViewModel.sizeForTopOfCollectionView(),width: Constant.DEVICE_W, height: Constant.DEVICE_H)
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
    override func onDataDidLoad() {
        
//        if self.mapViewModel.isPullToRefresh == true {
//            self.mapViewModel.isPullToRefresh = false
//            if #available(iOS 10.0, *) {
//                self.adapter.collectionView?.refreshControl?.endRefreshing()
//            }
//        }
        adapter.performUpdates(animated: true, completion: nil)
    }
    
    override func onDataDidLoadErrorWithMessage(errorMessage: String) {
        showAlertPopup(title: "Error", message: errorMessage, yes_text: "OK")
    }
    
    override public func refrashCollectionView() {
        adapter.performUpdates(animated: true, completion: nil)
    }

    func setCollectionView() {
        
        collectionView = UICollectionView(frame:CGRect(x:0,y: self.mapViewModel.sizeForTopOfCollectionView(),width: Constant.DEVICE_W, height: Constant.DEVICE_H), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.backgroundColor = UIColor.white
        view.addSubview(collectionView!)
        
        adapter.collectionView = collectionView
        
        if #available(iOS 10.0, *) {
            adapter.collectionView?.refreshControl = UIRefreshControl()
            adapter.collectionView?.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        }
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
    }
    
    func pullToRefresh() {
        self.mapViewModel = MapViewModel(delegate: self)
//        self.mapViewModel.isPullToRefresh = true
//        self.mapViewModel.getMovieList()
    }
}

extension SearchListViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.mapViewModel.map
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is MapModel:
            return SearchSectionController()
//        default: return ListSectionController()
        default: return ListSectionController()

        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let nibView = Bundle.main.loadNibNamed("EmptyView", owner: nil, options: nil)!.first as! EmptyView
        return nibView
    }
}

extension SearchListViewController: UIScrollViewDelegate{
//, EmptyViewDelegate {
    
    func didReload() {
        adapter.performUpdates(animated: true, completion: nil)
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
//        let nextMovieAvailable = (self.movieViewModel.movie as? [MapModel])?.last?.nextMovieAvailable
//        if nextMovieAvailable == true && distance < 200 {
//            self.mapViewModel.map.append(LoadingType.loadmore.rawValue as ListDiffable)
//            adapter.performUpdates(animated: true, completion: nil)
//        }
//    }
}
