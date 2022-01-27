//
//  Principal.m
//  EventosGNP
//
//  Created by sensey on 10/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Principal.h"
#import "SWRevealViewController.h"


@interface Principal ()

@end

@implementation Principal

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_menu.target = self.revealViewController;
    //_menu.action = @selector(revealToggle:);
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //info = [[NSMutableArray alloc] init];
    //info = [defaults objectForKey:@"Info"];
    
    //[_nombreAgente setText:[info valueForKey:@"nickname"]];
    
    [self menuOpen];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if( [[UIScreen mainScreen] bounds].size.width == 320){
        //Linea para meter background en la Navbar
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"5s.jpg"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"6p.jpg"] forBarMetrics:UIBarMetricsDefault];
    }
    
    //NSLog(@"ViewDidLoad de Principal");
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    [_nombreAgente setText:[info valueForKey:@"nickname"]];
    
    //NSLog(@"%@",info);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)menuOpen{
    
    //NSLog(@"Menu Abierto XD");
    
    _menu.target = self.revealViewController;
    _menu.action = @selector(revealToggle:);
    
    //_menu.action = @selector(x);
    
}

-(void)x{
    //NSLog(@"xDDD");
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Funcion prepareForSegue Ejecutada");
}

- (IBAction)senderHome:(UITapGestureRecognizer *)sender {
    NSLog(@"Funcion senderHome Ejecutada");
}
- (IBAction)senderMensaje:(UITapGestureRecognizer *)sender {}
- (IBAction)senderNotifica:(UITapGestureRecognizer *)sender {}
- (IBAction)senderPerfil:(UITapGestureRecognizer *)sender {}
- (IBAction)senderAyuda:(UITapGestureRecognizer *)sender {}

@end
