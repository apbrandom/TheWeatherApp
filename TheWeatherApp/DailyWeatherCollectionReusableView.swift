//
//  DailyWeatherCollectionReusableView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 29.09.2023.
//

import UIKit

class DailyWeatherCollectionReusableView: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    var dailyWeatherData: [ForecastsModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var viewModel: WeatherViewModel
    
    //MARK: - Subviews
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "DailyWeatherCollectionViewCell")
        return collectionView
    }()
    
    //MARK: - Intialization
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - <#Section Heading#>
    private func setupSubviews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func convert(_ originalDate: String) -> String? {
        let originalFormatter = DateFormatter()
        originalFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = originalFormatter.date(from: originalDate) else {
            print("Ошибка в исходном формате даты")
            return nil
        }
        
        let targetFormatter = DateFormatter()
        targetFormatter.dateFormat = "dd/MM"
        
        return targetFormatter.string(from: date)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dailyWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyWeatherCollectionViewCell", for: indexPath) as? DailyWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let dailydata = dailyWeatherData[indexPath.row]
        cell.dataLabel.text = convert(dailydata.date)
        cell.chanceOfRainLabel.text = "\(dailydata.parts.day.precProb)%"
        cell.conditionLabel.text = viewModel.getWeatherCondition()
        cell.temperatureRangeLabel.text = "\(dailydata.parts.day.tempMin)\u{00B0}-\(dailydata.parts.day.tempMax)\u{00B0}"
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = bounds.size.width / 6.2
        return CGSize(width: self.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
