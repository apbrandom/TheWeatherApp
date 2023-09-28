//
//  AttributedTitle.swift
//  TheWeatherApp
//
//  Created by Vadim Vinogradov on 27.09.2023.
//

import UIKit

struct AttributedTitle {
    static func getUnderlineStyle(title: String, fontSize: CGFloat, kern: Double) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .kern: kern,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        return attributedTitle
    }
}
