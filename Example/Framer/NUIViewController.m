//
//  NUIViewController.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/14/2016.
//  Copyright (c) 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIViewController.h"

#import <Framer/NUIFramer.h>

@interface NUIViewController ()

@property (nonatomic) UIView *view1;
@property (nonatomic) UIView *view2;
@property (nonatomic) UIView *view3;

@property (nonatomic) UILabel *label1;
@property (nonatomic) UILabel *label2;
@property (nonatomic) UILabel *label3;


@end

@implementation NUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"HELLO1!";
    [self.view addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"ALL GOOOD";
    [self.view addSubview:self.label2];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"HELLO AGAIN!";
    [self.view addSubview:self.label3];
    
    
    
    //    self.view1 = [[UIView alloc] init];
    //    self.view1.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:self.view1];
    //
    //    self.view2 = [[UIView alloc] init];
    //    self.view2.backgroundColor = [UIColor greenColor];
    //    [self.view addSubview:self.view2];
    
    
    
    //    self.view3 = [[UIView alloc] init];
    //    self.view3.backgroundColor = [UIColor yellowColor];
    //    [self.view addSubview:self.view3];
    //
    //    self.view1 = [[UIView alloc] init];
    //    self.view1.backgroundColor = [UIColor redColor];
    //    [self.view3 addSubview:self.view1];
    //
    //    self.view2 = [[UIView alloc] init];
    //    self.view2.backgroundColor = [UIColor greenColor];
    //    [self.view3 addSubview:self.view2];
    
}

- (void)dealloc {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [self.label1 installFrames:^(NUIFramer *framer) {
        framer.super_centerX(0);
        framer.super_centerY(0);
    }];
    
    [self.label2 installFrames:^(NUIFramer *framer) {
        framer.super_centerX(0);
        framer.bottom_to(self.label1, 40);
    }];
    

    
    //    [self.view3 installFrames:^(NUIFramer *framer) {
    //        framer.super_centerY(0);
    //        framer.super_centerX(0);
    //        framer.height(200).width(200);
    //    }];
    //
    //    [self.view1 installFrames:^(NUIFramer *framer) {
    //        framer.left(10).top(10).bottom(10);
    //        framer.width(100);
    //    }];
    //
    //    [self.view2 installFrames:^(NUIFramer *framer) {
    //        framer.top(0).right(0).bottom(0).left_to(self.view1, 0);
    //    }];
    
    
    
    //    [self.view1 installFrames:^(NUIFramer *framer) {
    //        framer.super_centerY(0);
    //        framer.super_centerX(0);
    //        framer.height(100).width(100);
    //    }];
    //
    //    [self.view2 installFrames:^(NUIFramer *framer) {
    //        framer.width(50).height(50);
    //        framer.centerX_to(self.view2.superview, 0);
    //        framer.top_to(self.view1, 30);
    //    }];
}


@end
