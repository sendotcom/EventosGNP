//
//  PerfilEdicion.h
//  EventosGNP
//
//  Created by sensey on 23/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"

@interface PerfilEdicion : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,restDelegate>{
   
    NSString *aidi;
    NSString *peticion;
    NSMutableArray* info;
    NSMutableArray *datos;
    NSMutableArray *infoPerfilOne;
    UIView *fondo;
    
    int tServicio;
    
    UIButton *fondoBoton;
    UIImageView *fondoImagen;
    UILabel *fondoTexto;
    
    IBOutlet UIImageView *imagePhoto;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollEdit;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *back;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *botonFlechaGuardar;

- (IBAction)backEdicion:(UIBarButtonItem *)sender;

/* Los inputs 13 Campos en total */
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *lastname_p;
@property (weak, nonatomic) IBOutlet UITextField *lastname_m;
@property (weak, nonatomic) IBOutlet UITextField *birthdate;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *passport;
@property (weak, nonatomic) IBOutlet UITextField *visa;
@property (weak, nonatomic) IBOutlet UITextField *diet;
@property (weak, nonatomic) IBOutlet UITextField *allergies;
@property (weak, nonatomic) IBOutlet UITextField *special_conditions;
@property (weak, nonatomic) IBOutlet UITextField *smoker;
@property (weak, nonatomic) IBOutlet UIImageView *imagenPerfil;

- (IBAction)guardaPerfilDown:(id)sender;
- (IBAction)guardarPerfil:(UIBarButtonItem *)sender;
- (IBAction)actionSheet:(UIButton *)sender;
- (IBAction)cambiaAlergias:(id)sender;
- (IBAction)cambiaGenero:(id)sender;
- (IBAction)cambiaRegimen:(id)sender;
- (IBAction)cambiaCondiciones:(id)sender;
- (IBAction)cambiaFumador:(id)sender;


@end
