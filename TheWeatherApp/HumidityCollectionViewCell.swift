//
//  ChanceOfRainCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.10.2023.
//

import UIKit

class HumidityCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = "ChanceOfRainCollectionViewCell"
    
    //MARK: - Subviews
    lazy var humidityLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = "25%"
        return label
    }()
    
    lazy var humidityImage = {
        let image = UIImageView(image: .humidity)
        return image
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
        addSubview(humidityLabel)
        addSubview(humidityImage)
    }
    
    func setupConstraints() {
        humidityLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        humidityImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview() // отступ снизу
            make.top.equalTo(humidityLabel.snp.bottom) //
        }
    }
}
