//
//  HourlyWeatherCardCollectionReusableView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 26.09.2023.
//

import UIKit
import SnapKit

class HourlyWeatherCardCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    var viewModel: WeatherViewModel
    
    var hoursWeatherData: [HourModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Subviews
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCardViewCell.self, forCellWithReuseIdentifier: WeatherCardViewCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Initialization
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Setup Methods
    private func setupSubviews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HourlyWeatherCardCollectionReusableView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hoursWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCardViewCell.reuseIdentifier, for: indexPath) as? WeatherCardViewCell else {
            return UICollectionViewCell()
        }
        
        let hourData = hoursWeatherData[indexPath.row]
        cell.hourTimeIntervalLabel.text = ToolsService.convertHour(hourData.hour)
        cell.temperatureLabel.text = "\(hourData.temp)\u{00B0}"
        viewModel.setWeatherCondition(from: hourData.condition)
        cell.conditionIconImageView.image = viewModel.getWeatherImage()
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HourlyWeatherCardCollectionReusableView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bounds.size.width / 8.5
        return CGSize(width: width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
    }
}
