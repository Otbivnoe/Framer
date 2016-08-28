//
//  NUIFramerWidthHeightSpec.m
//  Framer
//
//  Created by Nikita on 06/08/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <Framer/Framer.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(WIDTHHEIGHTSPEC)

describe(@"Framer", ^{
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    UIView *nestedView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    UIView *nestedView2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 150)];
    
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
    
    context(@"should correctly configurate", ^{

        it(@"width relation", ^{
            
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.width(400);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 400, 50))];
        });

        it(@"height relation", ^{
            
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.height(400);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 50, 400))];
        });
        
        context(@"width_to relations:", ^{
            
            it(@"to anotherView.nui_width", ^{
                
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.width_to(nestedView2.nui_width, 0.5);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 100, 50))];
            });
            
            it(@"to anotherView.nui_height", ^{
                
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.width_to(nestedView2.nui_height, 1);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 150, 50))];
            });
            
            it(@"with top and bottom relations", ^{
                
                testingView.frame = CGRectZero;
                
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.top_to(nestedView2.nui_top, 10);
                    framer.bottom_to(nestedView1.nui_bottom, 10);
                    framer.width_to(testingView.nui_height, 0.5);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 160, 115, 230))];
                
                testingView.frame = CGRectZero;
                
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.top(10);
                    framer.bottom(10);
                    framer.width_to(testingView.nui_height, 0.5);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 10, 240, 480))];
            });
        });
        
        context(@"height_to relations:", ^{
            
            it(@"to anotherView.nui_width", ^{
                
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.height_to(nestedView2.nui_width, 0.5);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 50, 100))];
            });
            
            it(@"to anotherView.nui_height", ^{
                
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.height_to(nestedView2.nui_height, 1);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 50, 150))];
            });
            
            it(@"with left and right relations", ^{
                
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.left(10);
                    framer.right_to(nestedView2.nui_left, 10);
                    framer.height_to(testingView.nui_width, 0.5);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(10, 0, 130, 65))];
            });
            
        });
        
        it(@"height_to with another view and width_to to myself relations:", ^{
            
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.super_centerX(0.0);
                framer.super_centerY(0.0);
                framer.height_to(mainView.nui_width, 0.5);
                framer.width_to(testingView.nui_height, 0.5);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(187.5, 125, 125, 250))];
        });
        
        it(@"width_to with another view and height_to to myself relations:", ^{
            
            [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                framer.super_centerX(0.0);
                framer.super_centerY(0.0);
                framer.width_to(mainView.nui_height, 0.5);
                framer.height_to(testingView.nui_width, 0.5);
            }];
            
            [[theValue(testingView.frame) should] equal:theValue(CGRectMake(125, 187.5, 250, 125))];
        });
        
    });
    
});

SPEC_END
