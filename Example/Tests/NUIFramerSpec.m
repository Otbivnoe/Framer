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
                        framer.centerX_to(nestedView2.nui_left, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(125, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.nui_left, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(115, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerX", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.nui_centerX, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(225, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.nui_centerX, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(215, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.right", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.nui_right, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(325, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerX_to(nestedView2.nui_right, 10);
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
                        framer.centerY_to(nestedView2.nui_top, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 125, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.nui_top, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 115, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerY", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.nui_centerY, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 225, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.nui_centerY, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 215, 50, 50))];
                });
            });
            
            context(@"nestedView2.bottom", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.nui_bottom, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 325, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.centerY_to(nestedView2.nui_bottom, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 315, 50, 50))];
                });
            });
        });
        
        /*
            Just center_x and center_y
         */
        
        context(@"center_x and center_y", ^{
            specify(^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.centerX(30);
                    framer.centerY(10);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(5, -15, 50, 50))];
            });
        });
        
        /*
            BOTTOM_TO
         */
        
        context(@"bottom_to relation with", ^{
            
            context(@"nestedView2.top", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.bottom_to(nestedView2.nui_top, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 100, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.bottom_to(nestedView2.nui_top, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 90, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerY", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.bottom_to(nestedView2.nui_centerY, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 200, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.bottom_to(nestedView2.nui_centerY, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 190, 50, 50))];
                });
            });
            
            context(@"nestedView2.bottom", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.bottom_to(nestedView2.nui_bottom, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 300, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.bottom_to(nestedView2.nui_bottom, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 290, 50, 50))];
                });
            });
        });
        
        /*
            TOP_TO
         */
        
        context(@"top_to relation with", ^{
            
            context(@"nestedView2.top", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.top_to(nestedView2.nui_top, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 150, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.top_to(nestedView2.nui_top, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 160, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerY", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.top_to(nestedView2.nui_centerY, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 250, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.top_to(nestedView2.nui_centerY, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 260, 50, 50))];
                });
            });
            
            context(@"nestedView2.bottom", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.top_to(nestedView2.nui_bottom, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 350, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.top_to(nestedView2.nui_bottom, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 360, 50, 50))];
                });
            });
        });
        
        /*
            RIGHT_TO
         */
        
        context(@"right_to relation with", ^{
            
            context(@"nestedView2.right", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.right_to(nestedView2.nui_right, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(300, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.right_to(nestedView2.nui_right, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(290, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerX", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.right_to(nestedView2.nui_centerX, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(200, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.right_to(nestedView2.nui_centerX, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(190, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.left", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.right_to(nestedView2.nui_left, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(100, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.right_to(nestedView2.nui_left, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(90, 0, 50, 50))];
                });
            });
        });
        
        /*
            LEFT_TO
         */
        
        context(@"left_to relation with", ^{
            
            context(@"nestedView2.right", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.left_to(nestedView2.nui_right, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(350, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.left_to(nestedView2.nui_right, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(360, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.centerX", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.left_to(nestedView2.nui_centerX, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(250, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.left_to(nestedView2.nui_centerX, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(260, 0, 50, 50))];
                });
            });
            
            context(@"nestedView2.left", ^{
                
                it(@"with zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.left_to(nestedView2.nui_left, 0);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(150, 0, 50, 50))];
                });
                
                it(@"with non zero offset", ^{
                    [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                        framer.left_to(nestedView2.nui_left, 10);
                    }];
                    
                    [[theValue(testingView.frame) should] equal:theValue(CGRectMake(160, 0, 50, 50))];
                });
            });
        });
        
        /*
            LEFT
         */
        
        context(@"left to superview relation", ^{
            
            it(@"with zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.left(0);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 50, 50))];
            });
            
            it(@"with non zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.left(10);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(10, 0, 50, 50))];
            });
        });
        
        /*
            TOP
         */
        
        context(@"top to superview relation", ^{
            
            it(@"with zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.top(0);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 50, 50))];
            });
            
            it(@"with non zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.top(10);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 10, 50, 50))];
            });
        });
        
        /*
            BOTTOM
         */
        
        context(@"bottom to superview relation", ^{
            
            it(@"with zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.bottom(0);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 450, 50, 50))];
            });
            
            it(@"with non zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.bottom(10);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 440, 50, 50))];
            });
        });
        
        /*
            RIGHT
         */
        
        context(@"right to superview relation", ^{
            
            it(@"with zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.right(0);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(450, 0, 50, 50))];
            });
            
            it(@"with non zero offset", ^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.right(10);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(440, 0, 50, 50))];
            });
        });
        
        /*
            WIDTH
         */
        
        context(@"width relation", ^{
            
            specify(^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.width(400);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 400, 50))];
            });
        });
        
        /*
            HEIGHT
         */
        
        context(@"height relation", ^{
            
            specify(^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.height(400);
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(0, 0, 50, 400))];
            });
        });
        
        /*
            EDGES
         */
        
        context(@"edges with superview", ^{
            
            specify(^{
                [testingView installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.edges(UIEdgeInsetsMake(20, 20, 20, 20));
                }];
                
                [[theValue(testingView.frame) should] equal:theValue(CGRectMake(20, 20, 460, 460))];
            });
        });
        
        /*
            CONTAINER
         */
        
        context(@"container for wrapping subview", ^{
            
            specify(^{
                UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
                UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(70, 70, 50, 50)];
                
                UIView *container = [[UIView alloc] init];
                [container addSubview:view1];
                [container addSubview:view2];
                
                [container installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.container();
                }];
                
                [[theValue(container.frame) should] equal:theValue(CGRectMake(0, 0, 120, 120))];
            });
        });
        
        /*
            SIZE_TO_FIT
         */
        
        context(@"sizeToFit", ^{
            
            specify(^{
                UILabel *label = [[UILabel alloc] init];
                label.text = @"Hello!";
                [label installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.sizeToFit();
                }];
                
                [[theValue(CGRectGetWidth(label.frame)) should] beGreaterThan:theValue(0)];
                [[theValue(CGRectGetHeight(label.frame)) should] beGreaterThan:theValue(0)];
            });
        });
        
        /*
            SIZE_THAT_FITS
         */
        
        context(@"sizeThatFits", ^{
            
            specify(^{
                UILabel *label = [[UILabel alloc] init];
                label.text = @"Hello!";
                [label installFrames:^(NUIFramer * _Nonnull framer) {
                    framer.sizeThatFits(CGSizeMake(CGFLOAT_MAX, 0));
                }];
                
                [[theValue(CGRectGetWidth(label.frame)) should] beGreaterThan:theValue(0)];
                [[theValue(CGRectGetHeight(label.frame)) should] equal:0.0 withDelta:DBL_EPSILON];
            });
        });
        
    });
});

SPEC_END