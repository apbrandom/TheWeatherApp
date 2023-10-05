//
//  DetailWeatherViewController.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 14.09.2023.
//

import UIKit
import SnapKit

class DetailWeatherViewController: UIViewController {
    
    //MARK: - initialization
    var viewModel: DetailWeatherViewModel
    
    init(viewModel: DetailWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    
    let tempratureGraphView = {
        let view = temperatureGraphView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    //MARK: - Layout
    
    func setupView() {
        view.backgroundColor = .systemGray3
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        tempratureGraphView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
    }
}
