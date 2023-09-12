//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 11.09.2023.
//

import UIKit
import SnapKit

class MainWeatherViewController: UIViewController {
    
    private var fixedHeight: CGFloat = 0.0
    private let numberOfSections: CGFloat = 3.0
    
    //MARK: - Subviews
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .gray
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .cyan
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
#if DEBUG
        stackView.spacing = 5
#endif
        return stackView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
#if DEBUG
        view.backgroundColor = .tintColor
#endif
        return view
    }()
    
    private lazy var midView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutContentViews()
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .brown
    }
    
    private func layoutContentViews() {
        let dimension = view.window?.windowScene?.interfaceOrientation.isPortrait == true ?
        mainScrollView.frame.size.height : mainScrollView.frame.size.width
        
        fixedHeight = dimension / numberOfSections
        
        mainStackView.arrangedSubviews.forEach { view in
            view.snp.updateConstraints { make in
                make.height.equalTo(fixedHeight)
            }
        }
    }
    
    private func setupSubview() {
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

