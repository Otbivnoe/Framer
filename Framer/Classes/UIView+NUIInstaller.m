//
//  UIView+NUIInstaller.m
//  Framer
//
//  Created by Nikita Ermolenko on 06/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "UIView+NUIInstaller.h"
#import "NUIFramer.h"

@implementation UIView (NUIInstaller)

#pragma mark - Framer

- (void)installFrames:(void(^)(NUIFramer *_Nonnull framer))installerBlock {
    
    [NUIFramer configurateView:self withInstallerBlock:installerBlock];
}

@end
