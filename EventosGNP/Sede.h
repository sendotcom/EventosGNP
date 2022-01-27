//
//  Sede.h
//  EventosGNP
//
//  Created by sensey on 06/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"


@interface Sede : UIViewController<restDelegate>{
    
    NSString* identificadorLocal;
    NSMutableArray *infoEvento;
    
    NSString * eventoHotel;
    NSString * eventoLiga;

}

-(void) seteaIdentificador:(NSString*)ident;


@property (nonatomic,retain) IBOutlet UILabel *identificador;

@property(nonatomic,strong)NSString* idLocal;

@property (weak, nonatomic) IBOutlet UIScrollView *sedeScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgEvento;
@property (weak, nonatomic) IBOutlet UILabel *diaEvento;

@property (weak, nonatomic) IBOutlet UILabel *nombreEvento;
@property (weak, nonatomic) IBOutlet UILabel *eventoDireccion;

- (IBAction)verHotel;
@property (weak, nonatomic) IBOutlet UIButton *verHotelBoton;
@property (weak, nonatomic) IBOutlet UILabel *eventoDescripcion;
@property (weak, nonatomic) IBOutlet UILabel *eventoIntro;
@property (weak, nonatomic) IBOutlet UILabel *eventoDIa;
@property (weak, nonatomic) IBOutlet UIImageView *eventoImagenClima;
@property (weak, nonatomic) IBOutlet UILabel *climaMin;
@property (weak, nonatomic) IBOutlet UILabel *climaMax;

- (IBAction)eventoLiga:(id)sender;

@end


