//
//  NUIFramerSpec.m
//  Framer
//
//  Created by Nikita on 25/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <Framer/Framer.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(FRAMERSPEC)

describe(@"Framer", ^{
    
    /* Create nested views for careful testing */
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    UIView *nestedView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    UIView *nestedView2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];

    UIView *testingView = [[UIView alloc] init];
    
    beforeAll(^{
        [mainView addSubview:nestedView1];
        [nestedView1 addSubview:nestedView2];
        [mainView addSubview:testingView];
    });
    
    beforeEach(^{
        CGRect frame = CGRectMake(0, 0, 50, 50);
        testingView.frame = frame;
    });
    
    context(@"should correct configurate", ^{
        
        /*
            SUPER_CENTER_X
         */
        
        context(@"center_x relation with superview", ^{
            
            it(@"with zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.super_centerX(0);
                }];

                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(225, 0, 50, 50))];
            });
            
            it(@"with non zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.super_centerX(10);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(215, 0, 50, 50))];
            });
        });
        
        /*
            SUPER_CENTER_Y
         */

        context(@"center_y relation with superview", ^{
            
            it(@"with zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.super_centerY(0);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 225, 50, 50))];
            });
            
            it(@"with non zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.super_centerY(10);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 215, 50, 50))];
            });
        });
        
        /*
            CENTER_X
         */
        
        context(@"center_x relation with", ^{
            
            context(@"nestedView2.left", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.left, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(125, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.left, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(115, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerX", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.centerX, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(225, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.centerX, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(215, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.right", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.right, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(325, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.right, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(315, 0, 50, 50))];
                });
            });
            
        });
        
        /*
            CENTER_Y
         */
        
        context(@"center_y relation with", ^{
            
            context(@"nestedView2.top", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.top, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 125, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.top, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 115, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerY", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.centerY, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 225, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.centerY, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 215, 50, 50))];
                });
            });
            
            context(@"nestedView2.bottom", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.bottom, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 325, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.bottom, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 315, 50, 50))];
                });
            });
            
        });
        
    });
});

SPEC_END