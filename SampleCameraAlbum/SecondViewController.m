//
//  SecondViewController.m
//  SampleCameraAlbum
//
//  Created by Eriko Ichinohe on 2014/12/31.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初期化
    if (_library ==nil) {
        _library = [[ALAssetsLibrary alloc]init];
    }
    
    //試しに１０個置いてみるサンプル
//    UIImage *image = [UIImage imageNamed:@"nopreview.png"];
//    
//    
//    for (int i=0; i < 10; i++) {
//        int x = 0;
//        int y = 0;
//        
//        if (i % 2 == 1) {
//            x = 160;
//        }
//        
//        y = 160 * (i / 2);
//        
//        
//        UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 160, 160)];
//        imagev.image = image;
//        
//        [self.view addSubview:imagev];
//        
//    }
//    
//    self.view.frame = CGRectMake(0, 0, 320, 1800);

    
    //UserDefaultObjectを用意する
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //一旦配列に取り出す
    NSArray *assetsURLs = [defaults objectForKey:@"assetsURLs"];

    _counter = 0;
    
    for (NSString *assetsURL in assetsURLs) {
        [self showPhoto:assetsURL];
    }
    
    
    self.view.frame = CGRectMake(0, 0, 320, 1800);
    
}

-(void)showPhoto:(NSString *)url
{
        
    //URLからALAssetを取得
    [_library assetForURL:[NSURL URLWithString:url]
              resultBlock:^(ALAsset *asset) {
                  
                  //画像があればYES、無ければNOを返す
                  if(asset){
                      NSLog(@"データがあります");
                      //ALAssetRepresentationクラスのインスタンスの作成
                      ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
                      
                      //ALAssetRepresentationを使用して、フルスクリーン用の画像をUIImageに変換
                      //fullScreenImageで元画像と同じ解像度の写真を取得する。
                      
                      _img_x = 0;
                      _img_y = 0;
                      
                      if (_counter % 2 == 1) {
                          _img_x = 160;
                      }
                      
                      _img_y = 160 * (_counter / 2);

                      UIImage *fullscreenImage = [UIImage imageWithCGImage:[assetRepresentation fullResolutionImage]];
                      
                      UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(_img_x, _img_y, 160, 160)];
                      imagev.image = fullscreenImage;
                      
                      [self.view addSubview:imagev];
                      _counter++;

                  }else{
                      NSLog(@"データがありません");
                  }
                  
              } failureBlock: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
