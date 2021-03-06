//
//  AppDelegate.m
//  EventosGNP
//
//  Created by sensey on 03/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    
   // [Parse setApplicationId:@"00kWtr6PtkdwOX8wPBIPyWB6qG5UniIYGIX7xxN6"
        //          clientKey:@"GNv4scpg0bUSkKcUSEyWHjUJQ2ns2dj18Xlq8PlQ"];
    
    [Parse setApplicationId:@"1TLduSLZNc67nvDn01cmPBLBaNtgVhsP3TTMlljp" clientKey:@"oR6jjUfYr9rrtcVppDxtSwUxgmUVIIZOpadeJrUs"];

    // Register for Push Notitications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    //[application registerUserNotificationSettings:settings];
    //[application registerForRemoteNotifications];
    
    //-- Set Notification
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        //[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        //[application registerForRemoteNotifications];
        
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    //--- your custom code


    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //[PFPush handlePush:userInfo];
    
    [PFPush handlePush:userInfo];
    
    if ( application.applicationState == UIApplicationStateActive ){
        // app was already in the foregroun
        NSLog(@"No es Background");
        
        _navController = (mainNavViewController *)self.window.rootViewController;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        _viewController = (Notificaciones*)[mainStoryboard instantiateViewControllerWithIdentifier: @"notificacionIdent"];;
        [_navController pushViewController:_viewController animated:YES];
        
    }else{
        NSLog(@"Estamos en Background");
        
        _navController = (mainNavViewController *)self.window.rootViewController;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        _viewController = (Notificaciones*)[mainStoryboard instantiateViewControllerWithIdentifier: @"notificacionIdent"];;
        [_navController pushViewController:_viewController animated:YES];
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
