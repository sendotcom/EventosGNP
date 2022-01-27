//
//  NotificacionInterna.h
//  EventosGNP
//
//  Created by sensey on 20/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notificaciones.h"
#import "Rest.h"

@interface NotificacionInterna : UIViewController<restDelegate>

@property(strong,nonatomic) NSMutableArray* datosNotificacionInterna;

@property NSMutableArray* datosInterna;
@property (weak, nonatomic) IBOutlet UILabel *tituloNotificacionInterna;
@property (weak, nonatomic) IBOutlet UILabel *descripcionNotificacionInterna;
@property (weak, nonatomic) IBOutlet UILabel *horarioDescripcionInterna;

- (IBAction)botonRegresaNotInterna:(id)sender;
- (IBAction)botonEliminaNotInterna:(id)sender;


@end
