//
//  MidView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit
import SnapKit

class MidContentView: UIView {
    
    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var hourlyWeatherCardCollectionView: HourlyWeatherCardCollectionReusableView = {
        let collection = HourlyWeatherCardCollectionReusableView()
        collection.backgroundColor = .magenta
        return collection
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(hourlyWeatherCardCollectionView)
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(snp.center)
        }
        
        hourlyWeatherCardCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

