//
//  ShareResultController.swift
//  Swish
//
//  Created by Wooseong Kim on 2015. 10. 20..
//  Copyright © 2015년 Yooii Studios Co., LTD. All rights reserved.
//

import UIKit

class ShareResultViewController: UIViewController, SegueHandlerType, PhotoActionType, PhotoVoteType {

    // SegueHandlerType
    enum SegueIdentifier: String {
        case UnwindFromShareResultToMain
    }
    
    @IBOutlet weak var photoCardView: PhotoCardView!
    @IBOutlet weak var photoActionView: PhotoActionView!
    @IBOutlet weak var photoVoteView: PhotoVoteView!
    
    final var photo: Photo!
    
    // MARK: - View Cycle
    
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
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdentifierForSegue(segue) {
        case .UnwindFromShareResultToMain:
            // TODO: 돌아가기 전 필요한 처리가 있다면 해줄 것
            // FIXME: 완벽하게 unwind가 안되고 Dressing이 보이면서 unwind 되는 현상 해결 필요
            print("prepareForSegue: UnwindFromShareResultToMain")
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func cancelButtonDidTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
