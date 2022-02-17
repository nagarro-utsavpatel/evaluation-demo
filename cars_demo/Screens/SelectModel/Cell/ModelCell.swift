//
//  ModelCell.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import UIKit

class ModelCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!

    @IBOutlet private var titleLabelBackgroundView: UIView!
    @IBOutlet private var titleLabel: UILabel!

    @IBOutlet private var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    private func setupUI() {
        containerView.setShadow(shadowRadius: 4)
        titleLabelBackgroundView.backgroundColor = .gray.withAlphaComponent(0.5)
//        titleLabelBackgroundView.setShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(model: ModelCellViewModel) {
        titleLabel.text = model.name
        iconImageView.image = UIImage(named: "car\(Int.random(in: 1..<5))")
    }
}

fileprivate extension UIView {
    func setShadow(shadowRadius: CGFloat = 10, cornerRadius: CGFloat = 16) {
        layer.cornerRadius = cornerRadius

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = shadowRadius
    }
}
