//
//  NUIViewController.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/14/2016.
//  Copyright (c) 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIViewController.h"

#import <Framer/Framer.h>

@interface NUIViewController ()

@property (nonatomic) UIView *view1;
@property (nonatomic) UIView *view2;
@property (nonatomic) UIView *view3;
@property (nonatomic) UIView *view4;

@property (nonatomic) UILabel *label1;
@property (nonatomic) UILabel *label2;
@property (nonatomic) UILabel *label3;

@end

@implementation NUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.label1 = [[UILabel alloc] init];
//    self.label1.text = @"HELLO1!";
//    [self.view addSubview:self.label1];
//    
//    self.label2 = [[UILabel alloc] init];
//    self.label2.text = @"ALL GOOOD";
//    [self.view addSubview:self.label2];
//    
//    self.label3 = [[UILabel alloc] init];
//    self.label3.text = @"HELLO AGAIN!";
//    [self.view addSubview:self.label3];
    
    
    self.view1 = [[UIView alloc] init];
    self.view1.backgroundColor = [UIColor redColor];
    
    self.view2 = [[UIView alloc] init];
    self.view2.backgroundColor = [UIColor blueColor];
    
    self.view3 = [[UIView alloc] init];
    self.view3.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view3];
    
    self.view4 = [[UIView alloc] init];
    self.view4.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.view4];
    
}

- (void)dealloc {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    
    [self.view1 installFrames:^(NUIFramer *framer) {
        framer.width(100);
        framer.height(100);
        framer.super_centerX(0);
        framer.super_centerY(0);
    }];
    
    [self.view2 installFrames:^(NUIFramer *framer) {
        framer.width(40).and.height(40);
        framer.centerY_to(self.view1.bottom, 0);
        framer.centerX_to(self.view1.centerX, 0);
    }];
    
}


@end
