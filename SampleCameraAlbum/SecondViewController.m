//
//  SecondViewController.m
//  SampleCameraAlbum
//
//  Created by Eriko Ichinohe on 2014/12/31.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [UIImage imageNamed:@"nopreview.png"];
    UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    imagev.image = image;
    
    [self.view addSubview:imagev];
    
    
    UIImageView *imagev2 = [[UIImageView alloc]initWithFrame:CGRectMake(160, 0, 160, 160)];
    imagev2.image = image;
    
    [self.view addSubview:imagev2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
