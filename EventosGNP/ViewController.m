//
//  ViewController.m
//  Servicios
//
//  Created by sensey on 03/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    //Linea para ocultar el navigation view controller en la priemra pagina
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //Vemos si esta ya logeado
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *datos = [NSMutableDictionary new];
    
    datos = [defaults objectForKey:@"json"];
    
    if([self estaLogeado]){
        
        [self performSegueWithIdentifier:@"principal" sender:self];
        
        
    }else{
          NSLog(@"No esta logeado");
    }
    
    /* Fragmento e codigo para ocultar teclado*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ocultaTeclado:)];
    
    [tapGesture setNumberOfTouchesRequired:1];
    [[self view] addGestureRecognizer:tapGesture];
    
    
    // NSLog(@"%f",[[UIScreen mainScreen] bounds].size.width);
    // NSLog(@"%f",[[UIScreen mainScreen] bounds].size.height);
    
    
}


-(void)ocultaTeclado:(UITapGestureRecognizer *)sender{
    
    [userTxt resignFirstResponder];
    [passwordTxt resignFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)login:(UIButton *)sender {
    
    [self validar];
    
    
    
}
/* FUNCION PARA VALIDAR */
-(void)validar{
    
    if ([userTxt.text isEqualToString:@""]) {
        errorLabel.hidden = NO;
        
        errorLabel.text = @"El usuario no puede ir vacio";
        
    }else if ([passwordTxt.text isEqualToString:@""]){
        
        errorLabel.hidden = NO;
        errorLabel.text = @"Ingresa una contraseña";
        
    }else{
        
        errorLabel.hidden = YES;
        
        Rest* wsRest = [[Rest alloc] init];
        
        wsRest.delegate = self;
        [wsRest restPostUrl:@"http://eventos.appsgnp.mx/api/login" withDic:[wsRest loginUser:userTxt.text password:passwordTxt.text]inView:self.view];
    }
}
/* FUNCIÓN PARA VER SI ESTA LOGEADO */
-(BOOL)estaLogeado {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *datos = [NSMutableDictionary new];
    
    datos = [defaults objectForKey:@"json"];
    
    if([[datos valueForKey:@"valid"] isEqualToString:@"1"]){
        return YES;
    }else{
        return NO;
    }
    
}

-(void)cierraMensaje{
    _mensajeErrorTxt.hidden = YES;
    _imgError.hidden = YES;
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *datos = [NSMutableDictionary new];

    if ([[[json valueForKey:@"valid"] stringValue] isEqualToString:@"0"]) {
        
        //errorLabel.hidden = NO;
        //errorLabel.text = [json valueForKey:@"message"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cierraMensaje)];
        
        [_imgError addGestureRecognizer:tap];
        
        _imgError.userInteractionEnabled = YES;
        
        _mensajeErrorTxt.hidden = NO;
        _imgError.hidden = NO;
        
    }else{
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        
        [currentInstallation setObject:[json valueForKey:@"id"] forKey:@"agentID"];
        [currentInstallation saveInBackground];
        
        _mensajeErrorTxt.hidden = YES;
        _imgError.hidden = YES;
        
        
        [datos setValue:@"1" forKey:@"valid"];
        
        [defaults setValue:datos forKey:@"json" ];
        [defaults setValue:json forKey:@"Info" ];

        [defaults synchronize];

        /* Segue a la principal */
        [self performSegueWithIdentifier:@"principal" sender:self];
        
    }
}

-(void)error:(NSString*)error{
    
    errorLabel.hidden = NO;
    
    [self AlertaShow:@"No se detecto conexión a Internet."];
    
    }

-(void)AlertaShow:(NSString*)Text{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:Text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

@end
