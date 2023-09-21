//
//  DotsProgressBar.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 13.09.2023.
//

//import UIKit
//
//class DotsProgressBar: UIView {
//    
//    private var stackView: UIStackView!
//    
//    var numberOfDots: Int = 0 {
//        didSet {
//            setupDots()
//        }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//    
//    private func commonInit() {
//        stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.spacing = 10
//        addSubview(stackView)
//        
//        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//    
//    private func setupDots() {
//        for view in stackView.arrangedSubviews {
//            stackView.removeArrangedSubview(view)
//            view.removeFromSuperview()
//        }
//        
//        for _ in 0..<numberOfDots {
//            let dotView = UIView()
//            dotView.backgroundColor = .gray
//            dotView.layer.cornerRadius = 5 // Размер вашего выбора
//            dotView.clipsToBounds = true
//            
//            stackView.addArrangedSubview(dotView)
//            
//            dotView.snp.makeConstraints { make in
//                make.width.height.equalTo(10) // Размер вашего выбора
//            }
//        }
//    }
//    
//}
