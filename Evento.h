//
//  Evento.h
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"
#import "UIImageView+AFNetworking.h"
#import "TipoA.h"
#import "TipoB.h"
#import "Sede.h"


@interface Evento : UIViewController<restDelegate>{
    BOOL tipo;
    NSMutableArray *eventos;
}

@property (weak,nonatomic) IBOutlet UIBarButtonItem *menu;
@property (weak, nonatomic) IBOutlet UITableView *tablaVista;
@property (strong,nonatomic) IBOutlet UILabel *identificador;


@end
