//
//  MyProfileViewController.swift
//  Swish
//
//  Created by Wooseong Kim on 2016. 1. 6..
//  Copyright © 2016년 Yooii Studios Co., LTD. All rights reserved.
//

import UIKit
import AlamofireImage

class MyProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var sentPhotoCountLabel: UILabel!
    @IBOutlet weak var likedPhotoCountLabel: UILabel!
    @IBOutlet weak var dislikedPhotoCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    private func initUI() {
        initUserImageView()
        initUserLabels()
        initUserActivityView()
    }
    
    private func initUserImageView() {
        MeObserver.observeProfileUrl(self, handler: { [unowned self] profileUrl in
            ImageDownloader.downloadImage(profileUrl) { [unowned self] image in
                if let image = image {
                    self.profileImageView.image = image
                }
            }
        })
    }
    
    private func initUserLabels() {
        MeObserver.observeName(self, handler: { [unowned self] name in
            self.nameLabel.text = name
        })
        
        MeObserver.observeAbout(self, handler: { [unowned self] about in
            self.aboutLabel.text = about
        })
    }
    
    private func initUserActivityView() {
        let userActivityRecord = MeManager.me().userActivityRecord
        sentPhotoCountLabel.text = String(userActivityRecord.sentPhotoCount)
        likedPhotoCountLabel.text = String(userActivityRecord.likedPhotoCount)
        dislikedPhotoCountLabel.text = String(userActivityRecord.dislikedPhotoCount)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
