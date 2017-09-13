//
//  ViewController.m
//  clockTest
//
//  Created by wanglei on 2017/9/13.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "ViewController.h"
#import "HNEmotionCircleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HNEmotionCircleView *view = [[HNEmotionCircleView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 300)];
    [self.view addSubview:view];
    [view setProgress:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
