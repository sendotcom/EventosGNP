//
//  PerfilEdicion.m
//  EventosGNP
//
//  Created by sensey on 23/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "PerfilEdicion.h"
#import "SWRevealViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetPicker.h"

@interface PerfilEdicion ()

@end

@implementation PerfilEdicion

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _back.target = self.revealViewController;
    _back.action = @selector(backEdicion:);
    
    [self maestro];
    
}


-(void)maestro{
    
    _back.target = self.revealViewController;
    _back.action = @selector(backEdicion:);
    
    [self.scrollEdit setScrollEnabled:YES];
    [self.scrollEdit setContentSize:CGSizeMake(320, 1400)];
    
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
    
    tServicio = 1;
    wsRest.delegate = self;
   
    [wsRest restPostUrl:peticion withDic:[wsRest getDatos]inView:self.view];
    /* Termina creacion de objeto REST */
    
    /* Fragmento e codigo para ocultar teclado*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ocultaTeclado:)];
    [tapGesture setNumberOfTouchesRequired:1];
    
    [[self view] addGestureRecognizer:tapGesture];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    [self setTitle:@"EDICIÓN"];

}

-(void)llamadaRest{
    
    Rest *rest = [[Rest alloc] init];
 
    rest.delegate = self;
    

    
    [rest resPostWithImage:@"http://eventos.appsgnp.mx/api/perfil/guardar" withDic:[rest name:self.name.text lastname_p:self.lastname_p.text lastname_m:self.lastname_m.text nickname:self.nickname.text gender:self.gender.text birthdate:self.birthdate.text email:self.email.text passport:self.passport.text visa:self.visa.text diet:self.diet.text allergies:self.allergies.text special_conditions:self.special_conditions.text smoker:self.smoker.text aidi:[info valueForKey:@"id"]] inView:self.view image:self.imagenPerfil.image];
    
}

-(void)crearBack:(NSString*)mensaje{
    
    fondoBoton = [[UIButton alloc] initWithFrame:self.view.frame];
    
    [fondoBoton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //fondo = [[UIView alloc] initWithFrame:vista.frame];
    
    //UIImage *imagen = [[UIImage imageNamed:@"close.png"] init];
    
    fondoTexto = [[UILabel alloc] initWithFrame:self.view.frame];
    
    fondoImagen = [[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/3,[[UIScreen mainScreen] bounds].size.height/4.5,120,120)];
    
    UIImage *image = [UIImage imageNamed:@"save-ok.png"];
    
    [fondoImagen setImage:image];
    
    fondoTexto.numberOfLines = 2;
    fondoTexto.textAlignment = UITextAlignmentCenter;
    [fondoTexto setText:mensaje];
    [fondoTexto setTextColor:[UIColor whiteColor]];
    [fondoTexto setFont:[UIFont fontWithName: @"Roboto" size: 24.0f]];
    
    
    //COLOR EN RGB
    [fondoBoton setBackgroundColor:[UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.50]];
    
    [self.view addSubview:fondoBoton];
    [self.view addSubview:fondoTexto];
    [self.view addSubview:fondoImagen];
}

-(void) buttonClicked:(UIButton*)sender{
    
    [fondoBoton setHidden:YES];
    [fondoTexto setHidden:YES];
    [fondoImagen setHidden:YES];
    
    _botonFlechaGuardar.enabled = YES;
    
    [self maestro];
}

-(void)ocultaTeclado:(UITapGestureRecognizer *)sender{
    
    /* Los inputs 13 Campos en total */
    [self.name resignFirstResponder];
    [self.lastname_p resignFirstResponder];
    [self.lastname_m resignFirstResponder];
    [self.birthdate resignFirstResponder];
    [self.gender resignFirstResponder];
    [self.nickname resignFirstResponder];
    [self.email resignFirstResponder];
    [self.passport resignFirstResponder];
    [self.visa resignFirstResponder];
    [self.diet resignFirstResponder];
    [self.allergies resignFirstResponder];
    [self.special_conditions resignFirstResponder];
    [self.smoker resignFirstResponder];
    
}

- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    
    if (!titleView) {
        
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        
        titleView.font = [UIFont fontWithName:@"Roboto" size:24.0];
        
        
        titleView.textColor = [UIColor orangeColor];
        
        self.navigationItem.titleView = titleView;
        
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark rest delegate

/* Este servicio se ejecuta 2 veces */
-(void)success:(NSMutableArray*)json{
    
    //NSLog(@"INFORMACION : %@",json);
    
    if(tServicio == 0){
        
        //En este momento entra cuando guarda los cambios.
        [self crearBack:[json valueForKey:@"message"]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setValue:[json valueForKey:@"user"] forKey:@"Info" ];
        
        [defaults synchronize];
        
    }else{
        
        //En este momento entra cuando carga el perfil.
    
        infoPerfilOne = json;
        
        self.imagenPerfil.layer.cornerRadius = self.imagenPerfil.frame.size.width / 2;
        self.imagenPerfil.clipsToBounds = YES;
    
        [self.imagenPerfil setImageWithURL:[NSURL URLWithString:[infoPerfilOne valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
        [self.name setText:[infoPerfilOne valueForKey:@"name"]];
        [self.lastname_p setText:[infoPerfilOne valueForKey:@"lastname_p"]];
        [self.lastname_m setText:[infoPerfilOne valueForKey:@"lastname_m"]];
        [self.birthdate setText: [infoPerfilOne valueForKey:@"birthdate"]];
        [self.gender setText: [[infoPerfilOne valueForKey:@"gender"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
        [self.nickname setText: [[infoPerfilOne valueForKey:@"nickname"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
        [self.email setText: [infoPerfilOne valueForKey:@"email"]];
        [self.passport setText: [infoPerfilOne valueForKey:@"passport"]];
        [self.visa setText: [infoPerfilOne valueForKey:@"visa"]];
        [self.diet setText: [[infoPerfilOne valueForKey:@"diet"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
        [self.allergies setText: [[infoPerfilOne valueForKey:@"allergies"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
        [self.special_conditions setText: [[infoPerfilOne valueForKey:@"specialConditions"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
        [self.smoker setText: [[infoPerfilOne valueForKey:@"smoker"] capitalizedStringWithLocale:[NSLocale currentLocale]]];
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        
        [def setValue:[infoPerfilOne valueForKey:@"name"] forKey:@"fullName"];
        [def setValue:[infoPerfilOne valueForKey:@"image"] forKey:@"image"];
        [def synchronize];
        
    }
  
}

- (IBAction)backEdicion:(UIBarButtonItem *)sender {
    
   [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.scrollEdit setContentOffset:CGPointMake(0,textField.frame.origin.y-40) animated:YES];
    
    return YES;
}



-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}


- (IBAction)guardaPerfilDown:(id)sender {
    
    tServicio = 0;
    [self llamadaRest];
}

- (IBAction)guardarPerfil:(UIBarButtonItem *)sender {
    
    _botonFlechaGuardar.enabled = NO;
    
    tServicio = 0;
    [self llamadaRest];
}

- (IBAction)cambiarFoto:(UIButton *)sender {
    
}

- (IBAction)tomarFoto:(UIButton *)sender {
    
}

#pragma mark Methods Generic SE COPIO AQUI

-(void)AlertaShow:(NSString*)Text{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:Text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}




- (IBAction)actionSheet:(UIButton *)sender {
    [self showAlertSheet:@"Subir Foto" withMessage:@"Selecciona tu foto favorita"];
}

- (IBAction)cambiaAlergias:(id)sender {
    
    NSArray *colors = [NSArray arrayWithObjects:@"Ninguna", @"Alimentos", @"Polen", @"Polvo", @"Animales", @"Medicamentos", @"Insectos", @"Sol", @"Niquel", @"Latex", @"Zulfas", @"Celiaca", @"Otro", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Selecciona una Alergia"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           //NSLog(@"Picker: %@", picker);
                                           //NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           //NSLog(@"Selected Value: %@", selectedValue);
                                           
                                           [_allergies setText:selectedValue];
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         
                                         //NSLog(@"Block Picker Canceled");
                                         
                                     }
                                          origin:self.view];
    
}

- (IBAction)cambiaGenero:(id)sender {
    
    NSArray *colors = [NSArray arrayWithObjects:@"Masculino", @"Femenino", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Selecciona un genero"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           //NSLog(@"Picker: %@", picker);
                                           //NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           //NSLog(@"Selected Value: %@", selectedValue);
                                           
                                           [_gender setText:selectedValue];
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         
                                           //NSLog(@"Block Picker Canceled");
                                         
                                     }
                                          origin:self.view];
    
}

- (IBAction)cambiaRegimen:(id)sender {
    
    NSArray *colors = [NSArray arrayWithObjects:@"Ninguno", @"Vegetariano", @"Lactovegetariano", @"Ovevegetariano", @"Macrobiótico", @"Semivegetariano", @"Ovolactovegetariano", @"Otro", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Selecciona su régimen alimenticio"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           //NSLog(@"Picker: %@", picker);
                                           //NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           //NSLog(@"Selected Value: %@", selectedValue);
                                           
                                           [_diet setText:selectedValue];
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         
                                         //NSLog(@"Block Picker Canceled");
                                         
                                     }
                                          origin:self.view];
    
}

- (IBAction)cambiaCondiciones:(id)sender {
    
    NSArray *colors = [NSArray arrayWithObjects:@"Ninguno", @"Silla de ruedas", @"Baston", @"Embarazada", @"Operacion Reciente", @"Tercera Edad", @"Otro", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Condiciones especiales"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           //NSLog(@"Picker: %@", picker);
                                           //NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           //NSLog(@"Selected Value: %@", selectedValue);
                                           
                                           [_special_conditions setText:selectedValue];
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         
                                         //NSLog(@"Block Picker Canceled");
                                         
                                     }
                                          origin:self.view];
    
}

- (IBAction)cambiaFumador:(id)sender {
    
    NSArray *colors = [NSArray arrayWithObjects:@"Si",@"No", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Fumador?"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [_smoker setText:selectedValue];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         
                                     }
                                          origin:self.view];
    
    
}

-(void)showAlertSheet:(NSString*)alertTitle withMessage:(NSString*)alertMessage{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:alertTitle
                                          message:alertMessage
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Hacer Foto"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       NSLog(@"Soltar Control de camara");
                                       [self openPhotoLibraryIsCamera:YES];
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];  // UIAlertActionStyleCancel
    UIAlertAction *deleteAction = [UIAlertAction
                                   actionWithTitle:@"Fototeca"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       NSLog(@"Abrir Galeria de imaganes");
                                       [self openPhotoLibraryIsCamera:NO];
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];  // UIAlertActionStyleDestructive
    UIAlertAction *archiveAction = [UIAlertAction
                                    actionWithTitle:@"Cancelar"
                                    style:UIAlertActionStyleCancel
                                    handler:^(UIAlertAction * action)
                                    {
                                        [alertController dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Open Photo Gallery
-(void)openPhotoLibraryIsCamera:(BOOL)camera{
    
    NSLog(@"ejecuta funcion");
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    if (camera) {
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    }else
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - ImagePicker Controller Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        imagePhoto.image = image;
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        //Right some error related code...
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end