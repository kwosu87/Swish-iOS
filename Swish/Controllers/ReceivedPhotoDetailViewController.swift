//
//  ReceivedPhotoDetailViewController.swift
//  Swish
//
//  Created by Wooseong Kim on 2015. 12. 16..
//  Copyright © 2015년 Yooii Studios Co., LTD. All rights reserved.
//

import UIKit
import AlamofireImage

class ReceivedPhotoDetailViewController: UIViewController, PhotoActionType, PhotoVoteType {

    @IBOutlet weak var photoCardView: PhotoCardView!
    @IBOutlet weak var photoActionView: PhotoActionView!
    @IBOutlet weak var photoVoteView: PhotoVoteView!
    
    final var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpPhotoCardView()
        setUpPhotoActionView()
        setUpPhotoVoteView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        updatePhotoState()
    }
    
    // MARK: - Init
    
    private func setUpPhotoCardView() {
        photoCardView.setUpWithPhoto(photo)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelButtonDidTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // TODO: 테스트 이후 최종적으로 삭제 필요
    @IBAction func resetButtonDidTap(sender: AnyObject) {
        SwishDatabase.updatePhotoState(photo.id, photoState: .Delivered)
        // 원래 초기화에만 사용해야 하는 로직이지만 테스트를 위해서만 사용하고 추후 삭제 예정
        setUpPhotoVoteView()
    }
    
    // TODO: 테스트 이후 최종적으로 삭제 필요
    @IBAction func increaseWingsButtonDidTap(sender: AnyObject) {
        SwishDatabase.increaseUnreadChatCount(photo.id)
    }
}
