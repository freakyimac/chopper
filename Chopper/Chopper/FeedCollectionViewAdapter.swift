//
//  FeedCollectionViewAdapter.swift
//  Chopper
//
//  Created by 김동현 on 2023/06/19.
//

import UIKit

final class FeedCollectionViewAdapter: NSObject {
    
    enum MySection {
        case first([FirstItem])
        case second([SecondItem])
        
        struct FirstItem {
            let value: String
        }
        struct SecondItem {
            let value: String
        }
    }
    
    // MARK: - Properties
    private let sections: [MySection]
    
    // MARK: - initializer
    override init() {
        // test data
        sections = [
            .first((1...30).map(String.init).map(MySection.FirstItem.init(value:))),
            .second((31...60).map(String.init).map(MySection.SecondItem.init(value:))),
        ]
    }
}

// MARK: - UICollectionView DataSource
extension FeedCollectionViewAdapter: UICollectionViewDataSource {
    func getLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                // item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
                
                // group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .fractionalHeight(0.3)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 1
                )
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            default:
                // item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0/4.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
                
                // group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .fractionalHeight(0.3)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    repeatingSubitem: item,
                    count: 4
                )
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                return section
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.sections[section] {
        case let .first(items):
            return items.count
        case let .second(items):
            return items.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
            return .init()
        }
        switch self.sections[indexPath.section] {
        case let .first(items):
            cell.label.text = items[indexPath.item].value
        case let .second(items):
            cell.label.text = items[indexPath.item].value
        }
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension FeedCollectionViewAdapter: UICollectionViewDelegate {
    
}
