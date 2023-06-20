//
//  FeedViewController.swift
//  Chopper
//
//  Created by 김동현 on 2023/05/31.
//

import UIKit

final class FeedViewController: UIViewController {
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.adapter.getLayout())
        view.dataSource = self.adapter
        view.delegate = self.adapter
        view.backgroundColor = .white
        view.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        view.register(CommonReuseableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CommonReuseableView")
        return view
    }()
    
    // MARK: - Properties
    private lazy var adapter = FeedCollectionViewAdapter()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Functions
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
