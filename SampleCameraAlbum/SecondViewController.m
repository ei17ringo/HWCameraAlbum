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
    
    
    for (int i=0; i < 30; i++) {
        int x = 0;
        int y = 0;
        
        if (i % 2 == 1) {
            x = 160;
        }
        
        y = 160 * (i / 2);
        
        
        UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 160, 160)];
        imagev.image = image;
        
        [self.view addSubview:imagev];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
