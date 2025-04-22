//
//  PostsTableViewCell.swift
//  Asssignment05
//
//  Created by Deepak Kaligotla on 23/04/25.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    static let identifier = "PostCell"

    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let viewsLikesLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0

        bodyLabel.font = .systemFont(ofSize: 14)
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = .darkGray

        viewsLikesLabel.font = .systemFont(ofSize: 12)
        viewsLikesLabel.textColor = .gray

        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, viewsLikesLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
        viewsLikesLabel.text = "👁 \(post.views)  👍 \(post.reactions.likes)  👎 \(post.reactions.dislikes)"
    }
}
