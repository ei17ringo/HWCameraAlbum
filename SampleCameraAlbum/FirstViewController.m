//
//  FirstViewController.m
//  SampleCameraAlbum
//
//  Created by Eriko Ichinohe on 2014/12/31.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//
//  Tabbed Applicationをベースに作成しています

#import <AssetsLibrary/AssetsLibrary.h>

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初期化
    if (_library ==nil) {
        _library = [[ALAssetsLibrary alloc]init];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 写真を今撮る（カメラロール）処理
- (IBAction)tapChoosePhoto:(id)sender {
    
    //初期値として-1をセット
    UIImagePickerControllerSourceType sourceType = -1;
    
    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //カメラロール機能が使えなかったら、処理を中止する。
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        return;
    }
    
    //イメージピッカーの生成
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = (id)self;
    
    //イメージピッカー表示
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)tapTakePhoto:(id)sender {
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //カメラライブラリから選んだ写真のURLを取得。
    _assetsUrl = [(NSURL *)[info objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
    [self showPhoto:_assetsUrl];
    
    [picker dismissViewControllerAnimated:YES completion:nil];  //元の画面に戻る
}

//assetsから取得した画像を表示する
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
                      UIImage *fullscreenImage = [UIImage imageWithCGImage:[assetRepresentation fullScreenImage]];
                      self.previewImage.image = fullscreenImage; //イメージをセット
                  }else{
                      NSLog(@"データがありません");
                  }
                  
              } failureBlock: nil];
}

@end
