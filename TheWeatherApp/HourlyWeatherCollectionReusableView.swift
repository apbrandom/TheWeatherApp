//
//  HourlyWetherCollectionReusableView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.10.2023.
//

import UIKit

class HourlyWeatherCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    var viewModel: WeatherViewModel
    
    var hourlyWeatherData: [HourModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    enum Section: Int, CaseIterable {
        case WeatherCondtionImage
        case ChanceOfRainLabel
        case HourlyTimeIntervalLabel
    }
    
    // MARK: - Initializers
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupCollectionView()
        print(hourlyWeatherData)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - Setup Methods
    private func setupCollectionView() {
        addSubview(collectionView)
        
        collectionView.register(WeatherConditionImageCollectionViewCell.self, forCellWithReuseIdentifier: WeatherConditionImageCollectionViewCell.reuseIdentifier)
        collectionView.register(HumidityCollectionViewCell.self, forCellWithReuseIdentifier: HumidityCollectionViewCell.reuseIdentifier)
        collectionView.register(HourlyTimeIntervalCollectionViewCell.self, forCellWithReuseIdentifier: HourlyTimeIntervalCollectionViewCell.reuseIdentifier)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundColor = .clear
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HourlyWeatherCollectionReusableView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherData.count / 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError(FatalError.section)
        }
        
        let newIndex = indexPath.row * 3
        let hourlyWeather = hourlyWeatherData[newIndex]
        
        switch section {
        case .WeatherCondtionImage:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherConditionImageCollectionViewCell.reuseIdentifier, for: indexPath) as? WeatherConditionImageCollectionViewCell else {
                fatalError(FatalError.cell)
            }
            
            if newIndex < hourlyWeatherData.count {
                viewModel.setWeatherCondition(from: hourlyWeather.condition)
                cell.conditionIconImageView.image = viewModel.getWeatherImage()
            }
            
            return cell
            
        case .ChanceOfRainLabel:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumidityCollectionViewCell.reuseIdentifier, for: indexPath) as? HumidityCollectionViewCell else {
                fatalError(FatalError.cell)
            }
            
            if newIndex < hourlyWeatherData.count {
                cell.humidityLabel.text = "\(hourlyWeather.humidity)%"
            }
            
            return cell
            
        case .HourlyTimeIntervalLabel:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyTimeIntervalCollectionViewCell.reuseIdentifier, for: indexPath) as? HourlyTimeIntervalCollectionViewCell else {
                fatalError(FatalError.cell)
            }
            
            if newIndex < hourlyWeatherData.count {
                cell.hourlyTimeIntervalLabel.text = ToolsService.convertHour(hourlyWeather.hour)
            }
            
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HourlyWeatherCollectionReusableView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Измените эти значения на те, которые подходят вашему дизайну
        let itemWidth: CGFloat = 40.0
        let itemHeight: CGFloat = 40.0
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
