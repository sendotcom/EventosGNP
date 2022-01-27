//
//  RecuperarPassword.m
//  EventosGNP
//
//  Created by sensey on 06/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "RecuperarPassword.h"
 #import <MessageUI/MessageUI.h>
@interface RecuperarPassword ()

@end

@implementation RecuperarPassword

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


//Boton para recuperar la contraseñaz
- (IBAction)backRecoverPass:(UIButton *)sender {
    NSLog(@"Regresando a pantalla principal...");
    
}

//Tache que te regresa de la pantalla de recuperar password a la pantalla de login
- (IBAction)backLoginRestorePassword:(UIButton *)sender {
    NSLog(@"Regresando...");
}

- (IBAction)recuperaPassword:(UIButton *)sender {

    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    [wsRest restPostUrl:@"http://eventos.appsgnp.mx/api/reset-password" withDic:[wsRest recoverPass:self.campoEmail.text]inView:self.view];
    
}

-(void)AlertaShow:(NSString*)Text{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:Text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

-(void)cambiaTexto{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:omar.rodriguez@gnp.com.mx"]];
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cambiaTexto)];
    
    [_recuperaTexto addGestureRecognizer:tap];
    
    _recuperaTexto.userInteractionEnabled = YES;
    
    if([json valueForKey:@"error"]){
        [_recuperaTexto setText:@"Este correo no está relacionado con tu cuenta, inténtalo de nuevo, si no recuerdas tu correo asociado contáctanos en el siguiente correo para ayudarte: omar.rodriguez@gnp.com.mx"];
    }else{
         [self AlertaShow:[json valueForKey:@"message"]];
    }
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

@end