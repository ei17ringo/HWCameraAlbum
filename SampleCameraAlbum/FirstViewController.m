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

#pragma mark カメラ処理
- (IBAction)tapChoosePhoto:(id)sender {
    //カメラロールから選ぶ
    
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
    // 写真を今とる
    // カメラが使用可能かどうか判定する
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"カメラ機能へアクセスできません");
        return;
    }
    
    // UIImagePickerControllerのインスタンスを生成
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // デリゲートを設定
    imagePickerController.delegate = (id)self;
    
    // 画像の取得先をカメラに設定
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // 撮影画面をモーダルビューとして表示する
    [self presentViewController:imagePickerController animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //カメラライブラリから選んだ写真のURLを取得。
    _assetsUrl = [(NSURL *)[info objectForKey:@"UIImagePickerControllerReferenceURL"] absoluteString];
    
    [self showPhoto:_assetsUrl];
    
    if (!_assetsUrl){
        //カメラで撮った時
        UIImage *originalImage=(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        
        //originalImage=(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
        
        [_library writeImageToSavedPhotosAlbum:originalImage.CGImage orientation:(ALAssetOrientation)originalImage.imageOrientation completionBlock:^(NSURL *assetURL,NSError *error){
            if(error ){
                NSLog(@"えらー");
            }else{
                NSLog(@"save");
                _assetsUrl=[(NSURL *)assetURL absoluteString];
                [self showPhoto:_assetsUrl];
                
            }
        }];

    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];  //元の画面に戻る
}

//assetsから取得した画像を表示する
-(void)showPhoto:(NSString *)url
{
    
    //表示前にUserDefaultに保存
    [self seveAssetsURL];
    
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
                      self.noticeLabel.text = @"この写真がアルバムに追加されました";

                      self.previewImage.image = fullscreenImage; //イメージをセット
                  }else{
                      NSLog(@"データがありません");
                  }
                  
              } failureBlock: nil];
}

//UserDefaultにassetsURLを保存
-(void)seveAssetsURL{

    //UserDefaultObjectを用意する
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //一旦配列に取り出す
    NSMutableArray *assetsURLs = [[defaults objectForKey:@"assetsURLs"] mutableCopy];
    
    if (assetsURLs == nil) {
        assetsURLs = [NSMutableArray new];
    }
    
    //配列に新しいURLを追加
    [assetsURLs addObject:_assetsUrl];
    
    //assetsURLを保存
    [defaults setObject:assetsURLs forKey:@"assetsURLs"];
    
    [defaults synchronize];
}

@end
