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
    private lazy var dayCard: DayCardView = {
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
        addSubview(dayCard)
    }
    
    private func setupView() {
#if DEBUG
        backgroundColor = .systemRed
#else
        backgroundColor = .white
#endif
    }
    
    private func setupConstraints() {
        dayCard.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
