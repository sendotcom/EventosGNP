//
//  VerifyConnectionNetwork.h
//  Seguros Azteca
//
//  Created by Hugo Mauricio Jimenez Elizondo on 10/07/13.
//  Copyright (c) 2013 Juan Pablo Arcos Jimenez. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "Reachability.h"

@interface VerifyConnectionNetwork : NSObject
-(BOOL)ConnectionNetwork:(NSString*)Ip;

@end
