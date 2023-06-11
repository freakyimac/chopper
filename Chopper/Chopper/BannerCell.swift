//
//  BannerCell.swift
//  Chopper
//
//  Created by 김동현 on 2023/06/11.
//

import UIKit

final class BannerCell: UICollectionViewCell {
    
    static let identifier: String = "BannerCell"
    
    // MARK: - Views
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    // MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    private func setupViews() {
        contentView.backgroundColor = .red
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
