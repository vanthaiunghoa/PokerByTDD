//
//  CardView.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/20.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

@IBDesignable final class CardView: UIView {
    
    private var contentSize: CGSize!
    @IBOutlet private weak var rankLabel: UILabel! {
        didSet {
            setCard(card)
        }
    }
    @IBOutlet private weak var suitLabel: UILabel! {
        didSet {
            setCard(card)
        }
    }
    
    var card: Card? {
        didSet {
            setCard(card)
        }
    }
    
    private func setCard(_ card: Card?) {
        let shouldHiddenLabels = card == nil
        rankLabel?.isHidden = shouldHiddenLabels
        suitLabel?.isHidden = shouldHiddenLabels
        guard let card = card else { return }
        let rank = card.rank
        let suit = card.suit
        rankLabel.text = rank.rawValue
        rankLabel.textColor = suit.color()
        suitLabel.text = suit.rawValue
        suitLabel.textColor = suit.color()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func instantiate() -> UIView {
        return Bundle.main.loadNibNamed("CardView", owner: self)!.first! as! UIView
    }
    
    // イニシャライザの共通処理
    private func configure() {
        let view = instantiate()
        view.frame = bounds
        self.addSubview(view)
        contentSize = bounds.size
        self.layer.borderColor = UIColor(named: "pink")?.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

private extension Card.Suit {
    
    func color() -> UIColor {
        switch self {
        case .club, .spade:
            return .black
        case .diamond, .heart:
            return .red
        }
    }
}
