//
//  TopView.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 12.09.2023.
//

import UIKit
import SnapKit
import Combine

class TopContentView: UIView {
    
    var weatherModel: WeatherModel? {
        didSet {
            if let temp = weatherModel?.temp {
                dayCardView.tempText.text = "\(temp)"
            }
        }
    }

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Subviews
    private lazy var dayCardView: DayCardView = {
        let view = DayCardView()
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
    
    func bindToViewModel(_ viewModel: MainWeatherViewModel) {
        viewModel.$weatherModel
            .sink { [weak self] newWeatherModel in
                DispatchQueue.main.async {
                    if let temp = newWeatherModel?.temp {
                        self?.dayCardView.tempText.text = "\(temp)"
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func setupConstraints() {
        dayCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
