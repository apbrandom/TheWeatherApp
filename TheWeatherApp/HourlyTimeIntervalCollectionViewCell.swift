//
//  TimeWeatherCollectionViewCell.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.10.2023.
//

import UIKit

class HourlyTimeIntervalCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = "hourlyTimeIntervalCollectionViewCell"
    
    //MARK: - Subviews
    lazy var hourlyTimeIntervalLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "00:00"
        return label
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
        addSubview(hourlyTimeIntervalLabel)
    }
    
    func setupConstraints() {
        hourlyTimeIntervalLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
