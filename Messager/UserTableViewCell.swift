//
//  UserTableViewCell.swift
//  Messager
//
//  Created by minmin on 2021/10/11.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureC(user: User) {
        usernameLabel.text = user.username
        statusLabel.text = user.status
        setAvatar(avatarLink :user.avaterLink)
    }

    private func setAvatar(avatarLink: String) {
        if avatarLink != "" {

        } else {
            self.avatarImageView.image = UIImage(named: "avatar")?.circleMasked
        }
    }
}
