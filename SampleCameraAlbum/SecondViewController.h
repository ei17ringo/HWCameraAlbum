//
//  SecondViewController.h
//  SampleCameraAlbum
//
//  Created by Eriko Ichinohe on 2014/12/31.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController{
    ALAssetsLibrary *_library;  //ALAssetsLibraryのインスタンス
    int _img_x;
    int _img_y;
    int _counter;
}



@end

