//
//  NUIConfigurateProtocol.h
//  Framer
//
//  Created by Nikita Ermolenko on 09/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NUIFramer;
@protocol NUIConfigurateProtocol <NSObject>

@property (nonatomic) Class class;

- (void)additionalConfigurateForFramer:(NUIFramer *)framer;

@end
