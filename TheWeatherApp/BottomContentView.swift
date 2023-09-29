//
//  BottomContentView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit

class BottomContentView: UIView {
    
    var viewModel: MainWeatherViewModel
    
    // MARK: - Subviews
    
    private lazy var dailyWeatherCollectionView = {
        let collection = DailyWeatherCollectionReusableView(viewModel: viewModel)
        return collection
    }()
    
    // MARK: - Initializers
    init(viewModel: MainWeatherViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupSubviews() {
        addSubview(dailyWeatherCollectionView)
    }
    
    private func setupConstraints() {
        dailyWeatherCollectionView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    
}

extension BottomContentView: WeatherObserver {
    
    private func updateUI(with weatherModel: WeatherViewModel) {
        let dailyWeather = weatherModel.forecasts 
        dailyWeatherCollectionView.dailyWeatherData = dailyWeather
    }
    
    func didUpdateWeather(_ weather: WeatherViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI(with: weather)
        }
    }
}
