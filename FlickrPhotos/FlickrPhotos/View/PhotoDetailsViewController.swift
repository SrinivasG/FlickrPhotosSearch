//
//  PhotoDetailsViewController.swift
//  FlickrPhotos
//
//  Created by Srinivas Gadda on 11/05/24.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet private weak var tagsLbl: UILabel!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    
    var item: FeedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = item?.title
        tagsLbl.text = item?.tags
        guard let imageUrl = URL(string: item?.media.m ?? "") else {
            return
        }
        Task {
            imgView.image = await ImageManager().fetchImage(url: imageUrl)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
