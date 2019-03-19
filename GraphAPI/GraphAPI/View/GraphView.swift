//
//  GraphView.swift
//  GraphAPI
//
//  Created by Kartik Sachan on 20/03/19.
//  Copyright © 2019 Microsoft. All rights reserved.
//

import Foundation
import UIKit

class GraphView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var title: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        textLabel.textColor = .black
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .center
        textLabel.lineBreakMode = .byTruncatingTail
        textLabel.text = "Skype For Busines Graph API Test"
        return textLabel
    }()
    
    private lazy var lineSeperator: UIView = {
        let line = UIView()
        line.backgroundColor = UIGraphColor.lineSeparatorColor()
        return line
    }()
    
    private(set) lazy var fetchTokenButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIGraphColor.enabledButtonColor(), for: .normal)
        button.setTitle("Fetch ADAL Token", for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIGraphColor.lineSeparatorColor().cgColor
       return button
    }()
    
    private(set) lazy var callGraphAPI: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIGraphColor.enabledButtonColor(), for: .normal)
        button.setTitleColor(UIGraphColor.disabledButtonColor(), for: .disabled)
        button.isEnabled = false
        button.setTitle("Call GraphAPI", for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIGraphColor.lineSeparatorColor().cgColor
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIGraphColor.backgroundColor()
        addSubview(title)
        addSubview(lineSeperator)
        addSubview(fetchTokenButton)
        addSubview(callGraphAPI)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        let graphViewWidth = frame.width
        
        title.preferredMaxLayoutWidth = frame.width - 20
        title.frame = CGRect(x: 0, y: 300, width: graphViewWidth, height: 50)
        
        lineSeperator.frame.origin = CGPoint(x: 0, y: 350)
        lineSeperator.frame.size = CGSize(width: graphViewWidth, height: 0.5)
        
        // setting frame for dialog cancel button view
        fetchTokenButton.frame = CGRect(x: 0, y: 350.5, width: graphViewWidth/2, height: 55)
        
        // setting frame for dialog submit button view
        callGraphAPI.frame = CGRect(x: graphViewWidth/2, y: 350.5, width: graphViewWidth/2, height: 55)
        
    
        super.layoutSubviews()
    }
}

private class UIGraphColor {
    static func enabledButtonColor() -> UIColor {
        return UIColor(red: 0, green: 120/255.0, blue: 212/255.0, alpha: 1)
    }
    
    static func disabledButtonColor() -> UIColor {
        return UIColor(red: 166/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1)
    }
    
    static func lineSeparatorColor() -> UIColor {
        return UIColor(red: 184/255.0, green: 184/255.0, blue: 184/255.0, alpha: 1)
    }
    
    static func backgroundColor() -> UIColor {
        return UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 0.88)
    }
}
