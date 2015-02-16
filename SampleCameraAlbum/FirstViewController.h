//
//  FirstViewController.h
//  SampleCameraAlbum
//
//  Created by Eriko Ichinohe on 2014/12/31.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController{
    NSString *_assetsUrl;    //assetsUrlを格納するインスタンス
    ALAssetsLibrary *_library;  //ALAssetsLibraryのインスタンス
}

@property (weak, nonatomic) IBOutlet UIButton *choosePhoto;
@property (weak, nonatomic) IBOutlet UIButton *takePhoto;

- (IBAction)tapChoosePhoto:(id)sender;
- (IBAction)tapTakePhoto:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@end

