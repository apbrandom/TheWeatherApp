//
//  DayCard.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

import UIKit
import SnapKit

class DayCardView: UIView {
    
    open lazy var tempText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Text"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .tintColor
    }
    
    private func addSubviews() {
        addSubview(tempText)
    }
    
    private func setupConstrains() {
        tempText.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
