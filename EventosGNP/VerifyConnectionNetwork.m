//
//  VerifyConnectionNetwork.m
//  Seguros Azteca
//
//  Created by Hugo Mauricio Jimenez Elizondo on 10/07/13.
//  Copyright (c) 2013 Juan Pablo Arcos Jimenez. All rights reserved.
//

#import "VerifyConnectionNetwork.h"

@implementation VerifyConnectionNetwork

-(BOOL)ConnectionNetwork:(NSString*)Ip{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return 0;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    Reachability *r = [Reachability reachabilityWithHostName:Ip];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    return (isReachable && !needsConnection && internetStatus != NotReachable ? YES : NO);
}


@end
