//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.09.2023.
//

import UIKit
import SnapKit

class MainWeatherViewController: UIViewController {
    
    private var fixedHeightSubviews: CGFloat = 0.0
    private let numberOfSubviews: CGFloat = 3.0
    
    //MARK: - Subviews
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .gray
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
#if DEBUG
        stackView.backgroundColor = .cyan
        stackView.spacing = 5
#endif
        return stackView
    }()
    
    private lazy var topView: TopContentView = {
        let view = TopContentView()
        return view
    }()
    
    private lazy var midView: MidContentView = {
        let view = MidContentView()
        return view
    }()
    
    private lazy var bottomView: BottomContentView = {
        let view = BottomContentView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupNavgatoinBar()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        adjustSubviews()
    }
    
    //MARK: - Actions
    
    @objc func leftBarButtonTapped() {
        // Ваш код при нажатии на левую кнопку
    }
    
    @objc func rightBarButtonTapped() {
        // Ваш код при нажатии на правую кнопку
    }


    
    //MARK: - Private Methods
    private func setupView() {
#if DEBUG
        view.backgroundColor = .brown
#else
        view.backgroundColor = .white
#endif
    }
    
    private func setupNavgatoinBar() {
        navigationItem.title = "City, Country"
        
//        let customTitleView = NavigationTitleView()
//        
//        navigationItem.titleView = customTitleView

        let leftBarItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "location"), style: .plain, target: self, action: #selector(rightBarButtonTapped))

        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
        
//        let dotsProgressBar = DotsProgressBar()
//            dotsProgressBar.numberOfDots = 2
//            navigationItem.titleView = dotsProgressBar
            
    }
    
    private func adjustSubviews() {
        let dimension = view.window?.windowScene?.interfaceOrientation.isPortrait == true ?
        mainScrollView.frame.size.height : mainScrollView.frame.size.width
        
        fixedHeightSubviews = dimension / numberOfSubviews
        
        mainStackView.arrangedSubviews.forEach { view in
            view.snp.updateConstraints { make in
                make.height.equalTo(fixedHeightSubviews)
            }
        }
    }
    
    private func setupSubviews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topView)
        mainStackView.addArrangedSubview(midView)
        mainStackView.addArrangedSubview(bottomView)
    }
    
    private func setupConstraints() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(mainScrollView)
            make.width.equalTo(mainScrollView)
        }
    }
}

