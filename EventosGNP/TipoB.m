//
//  TipoB.m
//  EventosGNP
//
//  Created by sensey on 04/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "TipoB.h"

@interface TipoB ()

@end

@implementation TipoB

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.ideLocal);
    tabNavTB = [UITabBar appearance];
    
    [tabNavTB setBarTintColor:[UIColor orangeColor]];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    UITabBarController *tb = (UITabBarController *)self;
    
    UITabBarItem *tabBarItemEvento = [tb.tabBar.items objectAtIndex:0];
    
    [tabBarItemEvento setTitle:@"Sede"];
    
    [tabBarItemEvento setImage: [[UIImage imageNamed:@"evento_sede-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItemEvento setSelectedImage: [UIImage imageNamed:@"evento_sede.png"]];
    
    UITabBarItem *tabBarItemProg = [tb.tabBar.items objectAtIndex:1];
    
    [tabBarItemProg setTitle:@"Programa"];
    
    [tabBarItemProg setImage: [[UIImage imageNamed:@"evento_programa-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItemProg setSelectedImage: [UIImage imageNamed:@"evento_programa.png"]];
    
    UITabBarItem *tabBarItemTour = [tb.tabBar.items objectAtIndex:2];
    
    [tabBarItemTour setTitle:@"Talleres"];
    
    [tabBarItemTour setImage: [[UIImage imageNamed:@"evento_talleres.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItemTour setSelectedImage: [UIImage imageNamed:@"evento_talleres-active.png"]];
    
    
    UITabBarItem *tabBarItemConf = [tb.tabBar.items objectAtIndex:3];
    
    [tabBarItemConf setTitle:@"Conferencias"];
    
    [tabBarItemConf setImage: [[UIImage imageNamed:@"evento_conferencias.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItemConf setSelectedImage: [UIImage imageNamed:@"evento_conferencias-active.png"]];
    
    UITabBarItem *tabBarItemPon = [tb.tabBar.items objectAtIndex:4];
    
    [tabBarItemPon setTitle:@"Ponentes"];
    
    [tabBarItemPon setImage: [[UIImage imageNamed:@"evento_ponente.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItemPon setSelectedImage: [UIImage imageNamed:@"evento_ponente-active.png"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
