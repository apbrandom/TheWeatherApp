//
//  WeatherConditionImageCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.10.2023.
//

import UIKit

class WeatherConditionImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = "WeatherConditionImageCollectionViewCell"
    
    //MARK: - Subviews
    lazy var conditionIconImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = .sun
        return imageView
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Setup Methods
    func setupView() {
        
    }
    
    func setupSubviews() {
        addSubview(conditionIconImageView)
    }
    
    func setupConstraints() {
        conditionIconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Configuration Method
        func configure(with image: UIImage) {
            conditionIconImageView.image = image
        }
}
