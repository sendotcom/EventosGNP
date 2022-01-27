//
//  Perfil.m
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Perfil.h"
#import "SWRevealViewController.h"
#import "UIImageView+AFNetworking.h"

@interface Perfil ()

@end

@implementation Perfil

@synthesize scrollView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* Borde de la imagen */
    [self.imagenPerfil.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.imagenPerfil.layer setBorderWidth: 3.5];
    /* Termina borde imagen */
    
    /* Poner scroll en el scroll view */
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 630)];
    /* Termina scroll view*/
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    aidi = [info valueForKey:@"id"];
    /* Termina NSUserDefaults */
    
    
    /* Armamos la URL de peticion para el servicio*/
    peticion = @"http://eventos.appsgnp.mx/api/usuario/";
    
    // Concatenacion
    peticion = [NSString stringWithFormat:@"%@%@", peticion,aidi];
    /* Termina URL peticion */

    
    /* Creamos el objeto de REST para actualizar los datos*/
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    [wsRest restPostUrl:peticion withDic:[wsRest getDatos]inView:self.view];
    /* Termina creacion de objeto REST */
    
    /* LLmamamos al metodo que llena los inputs*/
    [self infoProfile];
    /* Termina llamada de metodo */
    
    
    _menu.target = self.revealViewController;
    _menu.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self setTitle:@"PERFIL"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    [self.imagenPerfil setImageWithURL:[NSURL URLWithString:[def valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMetodosRest:(NSDictionary *)json{
    //NSLog(@"%@",json);
}

- (IBAction)irPerfilDown:(id)sender {
    
    [self performSegueWithIdentifier:@"editaPerIntro" sender:self];
}


-(void)infoProfile{
    
    self.imagenPerfil.layer.cornerRadius = self.imagenPerfil.frame.size.width / 2;
    self.imagenPerfil.clipsToBounds = YES;
    
    [self.imagenPerfil setImageWithURL:[NSURL URLWithString:[infoPerfilOne valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonSettings:(UIBarButtonItem *)sender {
    
    NSLog(@"Entrando a settings...");
    
    //[self performSegueWithIdentifier:@"editSettings" sender:self];
}


#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    infoPerfilOne = json;
    
    [self.imagenPerfil setImageWithURL:[NSURL URLWithString:[infoPerfilOne valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
    [self.nombrePerfil setText:[infoPerfilOne valueForKey:@"name"]];
    
    //Nombre del perfil
    //[self.nombrePerfil setText:[info valueForKey:@"name"]];
    [self.nombrePerfil setText:[infoPerfilOne valueForKey:@"name"]];
    
    //Genero
    [self.generoOutlet setText: [[infoPerfilOne valueForKey:@"gender"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
    
    //Fecha de nacimiento
    [self.fechaOutlet setText: [infoPerfilOne valueForKey:@"birthdate"]];
    
    //Edad
    [self.edadOutlet setText: [infoPerfilOne valueForKey:@"age"]];
    
    //Gafete
    [self.gafeteOutlet setText: [[infoPerfilOne valueForKey:@"nickname"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
    
    //Correo Electronico
    [self.emailOutlet setText: [infoPerfilOne valueForKey:@"email"]];
    
    //Pasaporte
    [self.pasaporteOutlet setText: [infoPerfilOne valueForKey:@"passport"]];
    
    //Visa
    [self.visaOutlet setText: [infoPerfilOne valueForKey:@"visa"]];
    
    //Regimen Alimenticio
    [self.regimenOutlet setText: [[infoPerfilOne valueForKey:@"diet"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
    
    //Alergias
    [self.alergiaOutlet setText: [[infoPerfilOne valueForKey:@"allergies"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
    
    //Alergias
    [self.condicionesOutlet setText: [[infoPerfilOne valueForKey:@"specialConditions"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}
@end
