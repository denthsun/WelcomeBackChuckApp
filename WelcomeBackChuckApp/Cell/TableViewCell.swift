//
//  TableViewCell.swift
//  WelcomeBackChuckApp
//
//  Created by Denis Velikanov on 14.12.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    let label = UILabel()
    let imageForCell = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.backgroundColor = .systemIndigo
        [label, imageForCell].forEach { contentView.addSubview($0) }
        label.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: imageForCell.trailingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        imageForCell.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: label.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        imageForCell.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setLabel(textLabel: String) {
        label.text = textLabel
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
    }
    
    func setImage(settedImage: UIImage) {
      //  imageForCell.backgroundColor = .systemGray
        imageForCell.contentMode = .scaleAspectFit
        imageForCell.image = settedImage
    }

    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
}
