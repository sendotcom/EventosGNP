//
//  AvisosA.m
//  EventosGNP
//
//  Created by sensey on 13/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "AvisosA.h"

@interface AvisosA ()

@end

@implementation AvisosA

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fullURL = @"http://gnpapp.desarrollosmasclicks.com/api/avisos/2/ios";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [_webView setBackgroundColor:[UIColor orangeColor]];
    
    [_webView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:136/255.0 blue:59/255.0 alpha:1.0]];
    [_webView setOpaque:NO];
    [_webView loadRequest:requestObj];
    
    //[_scrollView setScrollEnabled:YES];
    //[_scrollView setContentSize:CGSizeMake(320,1500)];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:NO];
    
    //Linea para customizar el boton regresar
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    //Color de al texto e la navigation Bar
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    //Titulo del Navigation bar
    self.navigationController.navigationBar.topItem.title = @"AVISOS";
    //Estilos del titulo del navigation BAR
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName,
                                                                   [UIFont fontWithName:@"Roboto" size:24.0], NSFontAttributeName,nil];
    
    
    
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
