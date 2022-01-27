//
//  Perfil.h
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Rest.h"

@interface Perfil : UIViewController<restDelegate>{
    
    NSString *aidi;
    NSString *peticion;
    NSMutableArray *infoPerfilOne;
    
     NSMutableArray *info;
    
}

@property (weak,nonatomic)  IBOutlet UIScrollView *scrollView;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *menu;

@property (weak, nonatomic) IBOutlet UIImageView *imagenPerfil;
@property (weak, nonatomic) IBOutlet UILabel *nombrePerfil;
@property (weak, nonatomic) IBOutlet UILabel *generoOutlet;
@property (weak, nonatomic) IBOutlet UILabel *fechaOutlet;
@property (weak, nonatomic) IBOutlet UILabel *edadOutlet;
@property (weak, nonatomic) IBOutlet UILabel *gafeteOutlet;
@property (weak, nonatomic) IBOutlet UILabel *emailOutlet;
@property (weak, nonatomic) IBOutlet UILabel *pasaporteOutlet;
@property (weak, nonatomic) IBOutlet UILabel *visaOutlet;
@property (weak, nonatomic) IBOutlet UILabel *regimenOutlet;
@property (weak, nonatomic) IBOutlet UILabel *alergiaOutlet;
@property (weak, nonatomic) IBOutlet UILabel *condicionesOutlet;

- (IBAction)buttonSettings:(UIBarButtonItem *)sender;

 -(void)setMetodosRest:(NSDictionary*)json;
- (IBAction)irPerfilDown:(id)sender;

@end
