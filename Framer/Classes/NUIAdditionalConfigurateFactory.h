//
//  NUIAdditionalConfigurateFactory.h
//  Framer
//
//  Created by Nikita Ermolenko on 09/06/16.
//  Copyright © 2016 Nikita Ermolenko. All rights reserved.
//

#import "NUIConfigurateProtocol.h"

@interface NUIAdditionalConfigurateFactory : NSObject

+ (nonnull NSArray <id<NUIConfigurateProtocol>> *)additionalConfigurates;

@end
