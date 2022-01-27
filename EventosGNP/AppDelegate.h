//
//  AppDelegate.h
//  EventosGNP
//
//  Created by sensey on 03/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworkActivityIndicatorManager.h"
#import <Parse/Parse.h>
#import "mainNavViewController.h"
#import "Notificaciones.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) mainNavViewController *navController;
@property (nonatomic, strong) Notificaciones *viewController;

@end
