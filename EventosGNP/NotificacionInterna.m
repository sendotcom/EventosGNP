//
//  NotificacionInterna.m
//  EventosGNP
//
//  Created by sensey on 20/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "NotificacionInterna.h"

@interface NotificacionInterna ()

@end

@implementation NotificacionInterna

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Rest* rest = [[Rest alloc]init];
    rest.delegate = self;
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    [rest notificacionLeida:[info valueForKey:@"id"] idNotificacion:[_datosNotificacionInterna valueForKey:@"id"]];
    
    rest.delegate = self;
        
    [_tituloNotificacionInterna setText:[_datosNotificacionInterna valueForKey:@"short_text"]];
    [_descripcionNotificacionInterna setText:[_datosNotificacionInterna valueForKey:@"full_text"]];
    [_horarioDescripcionInterna setText:[_datosNotificacionInterna valueForKey:@"time"]];
    
}

- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    titleView.font = [UIFont fontWithName:@"Roboto" size:24.0];
    
    titleView.textColor = [UIColor orangeColor];
    
    self.navigationItem.titleView = titleView;
    
    titleView.text = title;
    
    [titleView sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)botonRegresaNotInterna:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)botonEliminaNotInterna:(id)sender {
    
    Rest* rest = [[Rest alloc]init];
    rest.delegate = self;
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    [rest deleteNotificacion:[info valueForKey:@"id"] idNotificacion:[_datosNotificacionInterna valueForKey:@"id"]  inView:self.view];
    
    rest.delegate = self;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

@end
