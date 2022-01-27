//
//  Notificaciones.h
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"
#import "UIImageView+AFNetworking.h"
#import "NotificacionInterna.h"

@interface Notificaciones : UIViewController <restDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    int seleccion;
    NSString *test;
    
}

@property(nonatomic, assign) int celdaSeleccionada;

@property (strong, nonatomic) NSMutableArray *notificaLista;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *menu;
@property (weak, nonatomic) IBOutlet UITableView *tablaNotificaciones;

@property(strong,nonatomic) NSMutableArray* datos;


@end
