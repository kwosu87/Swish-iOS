//
//  PhotoPickable.swift
//   UIViewController에서 구현해 사진을 고를 수 있는 기능을 제공하는 protocol
//
//  UIViewController에서 implement를 하고, 
//  var photoPickerDelegate: PhotoPickerDelegateHandler? 
//  선언을 해 준 뒤 viewDidLoad에서 다음과 같은 로직을 작성
// 
//  photoPickerDelegate = PhotoPickerDelegateHandler() { image in
//      self.showDressingViewContoller(image)
//  }
//
//  Swish
//
//  Created by Wooseong Kim on 2015. 10. 28..
//  Copyright © 2015년 Yooii Studios Co., LTD. All rights reserved.
//

import Foundation
import CTAssetsPickerController

final class PhotoPickerHandler: NSObject, CTAssetsPickerControllerDelegate {
    
    typealias Completion = (image: UIImage) -> Void
    
    final var completion: Completion
    
    init(completion: Completion) {
        self.completion = completion
    }
    
    // MARK: - Delegate Function
    
    final func assetsPickerController(picker: CTAssetsPickerController!, shouldSelectAsset asset: PHAsset!) -> Bool {
        return picker.selectedAssets.count < 1
    }
    
    final func assetsPickerController(picker: CTAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        guard assets.count > 0, let asset: PHAsset! = (assets as! [PHAsset])[0] else  {
            picker.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        let options = PHImageRequestOptions()
        options.resizeMode = .Exact
        options.deliveryMode = .HighQualityFormat
        
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSize.init(width: 640, height: 640),
            contentMode: .AspectFill, options: options) { image, info in
                picker.dismissViewControllerAnimated(false, completion: {
                    if let image = image {
                        self.completion(image: image.upwardedImage)
                    } else {
                        // TODO: image == nil일 경우 예외처리
                    }
                })
        }
    }
}

protocol PhotoPickable {
    
    var photoPickerHandler: PhotoPickerHandler? { get }
}

extension PhotoPickable where Self: UIViewController {

    private func createPickerController() -> CTAssetsPickerController{
        // init
        let picker = CTAssetsPickerController()
        picker.delegate = self.photoPickerHandler
        
        // set default album (Camera Roll)
        picker.defaultAssetCollection = PHAssetCollectionSubtype.SmartAlbumUserLibrary
        
        // create options for fetching photo only
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.Image.rawValue)
        
        // assign options
        picker.assetsFetchOptions = fetchOptions
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad {
            picker.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        }
        
        return picker
    }
    
    final func presentPhotoPickerContoller() {
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) -> Void in
            if status == PHAuthorizationStatus.Authorized {
                dispatch_async(dispatch_get_main_queue()) {
                    // TODO: 위쪽 주석이 불필요할 수 있으나 샘플 프로젝트를 계속 활용해 가야 하기에 마지막 마무리 후 일괄적으로 삭제 예정
                    let picker = self.createPickerController()
                    self.presentViewController(picker, animated: true, completion: nil)
                }
            }
        }
    }
}
