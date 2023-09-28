//
//  HourlyWeatherCardCollectionReusableView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 26.09.2023.
//

import UIKit
import SnapKit

class HourlyWeatherCardCollectionReusableView: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var hourlyWeatherData: [HourViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    init() {
        super.init(frame: .zero) 

        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCardViewCell.self, forCellWithReuseIdentifier: "WeatherCardViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
        
    private func setupSubviews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCardViewCell", for: indexPath) as? WeatherCardViewCell else {
            return UICollectionViewCell()
        }
        
        let hourData = hourlyWeatherData[indexPath.row]
        cell.hourTimeIntervalLabel.text = "\(hourData.hour)"
        cell.temperatureLabel.text = "\(hourData.temp)"
        return cell
    }
    

    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bounds.size.width / 8.5 // чтобы влезло 6 карточек горизонтально
        return CGSize(width: width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
    }
}
