//
//  FeedCell.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @MainActor
    func configureCell(item: FeedItem) {
        titleLabel.text = item.title
        if let url = URL(string: item.media.m) {
            Task {
                photoView.image = await ImageManager().fetchImage(url: url)
            }
        }
    }
}
