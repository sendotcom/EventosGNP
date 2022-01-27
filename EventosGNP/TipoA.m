//
//  TipoA.m
//  EventosGNP
//
//  Created by sensey on 01/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "TipoA.h"
#import <UIKit/UIKit.h>

@interface TipoA ()

@end

@implementation TipoA

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",_ideLocal);
    
    //Sede *sede = [[Sede alloc]init];
    
    //[sede setIdLocal:@"1"];
    
    //sede.idLocal = @"Test";
    
    //NSLog(@"Imprimiendo desde Clase TipoA: %@",_ideLocal);
    // Do any additional setup after loading the view.
    
  //  UITabBarController *tabVC = (UITabBarController*) self;
    //tabNavTA = [UITabBar appearance];
    
    //[tabNavTA setBarTintColor:[UIColor orangeColor]];
    //[[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    /*
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
    UIColor *titleHighlightedColor = [UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateHighlighted];
    */
    
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
    
    [tabBarItemTour setTitle:@"Tours"];
    
    [tabBarItemTour setImage: [[UIImage imageNamed:@"evento_tours-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItemTour setSelectedImage: [UIImage imageNamed:@"evento_tours.png"]];
    
    
    UITabBarItem *tabBarItemRev = [tb.tabBar.items objectAtIndex:3];
    
    [tabBarItemRev setTitle:@"Revista"];
    
    [tabBarItemRev setImage: [[UIImage imageNamed:@"evento_revista-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItemRev setSelectedImage: [UIImage imageNamed:@"evento_revista.png"]];
    
    UITabBarItem *actProgra = [tb.tabBar.items objectAtIndex:4];
    
    [actProgra setTitle:@"Avisos"];
    
    [actProgra setImage: [[UIImage imageNamed:@"evento_actividades-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [actProgra setSelectedImage: [UIImage imageNamed:@"evento_actividades.png"]];
    
    
    
    

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
