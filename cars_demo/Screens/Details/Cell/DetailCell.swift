//
//  TypeDetailCell.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet private var engineTypeSizeView: UIView!
    @IBOutlet private var engineTypeSizeLabel: UILabel!

    @IBOutlet private var transmissionTypeView: UIView!
    @IBOutlet private var transmissionTypeLabel: UILabel!

    @IBOutlet private var vehicleStyleSizeView: UIView!
    @IBOutlet private var vehicleStyleSizeLabel: UILabel!

    @IBOutlet private var numberOfSeatsView: UIView!
    @IBOutlet private var numberOfSeatsLabel: UILabel!

    @IBOutlet private var colors: UIStackView!
    @IBOutlet private var mainImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    private func setupUI() {
        mainImageView.setStyles(shadowRadius: 4,
                                cornerRadius: 80,
                                shadowColor: .black,
                                shadowOpacity: 0.8)
        setUp(view: engineTypeSizeView)
        setUp(view: transmissionTypeView)
        setUp(view: vehicleStyleSizeView)
        setUp(view: numberOfSeatsView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setup(model: StyleDetailsList) {
        mainImageView.image = UIImage(named: "car\(Int.random(in: 1..<5))")

        engineTypeSizeLabel.text = model.engineTypeSize.text?.1
        transmissionTypeLabel.text = model.transmissionType.text?.1
        vehicleStyleSizeLabel.text = model.vehicleStyleSize.text?.1
        numberOfSeatsLabel.text = model.numberOfSeats.text?.1

        colors.removeAllArrangedSubviews()

        guard let colorItems = model.colors.colors else {
            return
        }
        for item in colorItems.1 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraint(NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: 36))

            view.addConstraint(NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .width,
                                                  multiplier: 1,
                                                  constant: 0))
            view.backgroundColor = item
            view.setStyles(shadowRadius: 4,
                           cornerRadius: 18,
                           shadowColor: .lightGray,
                           shadowOpacity: 0.2)
            colors.addArrangedSubview(view)
        }
    }

    private func setUp(view: UIView) {
        view.backgroundColor = .blue.withAlphaComponent(0.5)
        view.setStyles(shadowRadius: 4,
                       cornerRadius: 8,
                       shadowColor: .blue,
                       shadowOpacity: 0.8)
    }
}
