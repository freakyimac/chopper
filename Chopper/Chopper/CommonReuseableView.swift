//
//  CommonReuseableView.swift
//  Chopper
//
//  Created by 김동현 on 2023/06/20.
//

import UIKit

final class CommonReuseableView: UICollectionReusableView {
    
    // MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupView() {
        backgroundColor = .purple
    }
}
