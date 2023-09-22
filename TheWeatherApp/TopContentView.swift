//
//  TopView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 12.09.2023.
//

import UIKit
import SnapKit

class TopContentView: UIView {
    
    // MARK: - Subviews
    private lazy var dayCardView: DayCardView = {
        let view = DayCardView()
        view.layer.cornerRadius = 5
        return view
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
        addSubview(dayCardView)
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    @MainActor
    func bindToViewModel(_ viewModel: MainWeatherViewModel) async {
        if let newWeatherModel = try? await viewModel.fetchWeather() {
            updateUI(with: newWeatherModel)
        }
    }

    private func updateUI(with weatherModel: WeatherViewModel) {
        let temp = weatherModel.fact.temp
        self.dayCardView.tempLabel.text = "\(temp)"
    }


    private func setupConstraints() {
        dayCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
