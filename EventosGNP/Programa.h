//
//  Programa.h
//  EventosGNP
//
//  Created by sensey on 10/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"
#import "UIImageView+AFNetworking.h"
#import "ProgramaInterna.h"
#import "TourInterna.h"


@interface Programa : UIViewController<restDelegate>{
    
     NSMutableArray *agendadas;
     NSMutableArray *eventos;

     int seleccion;
     BOOL selected,tipoServicio;
    
    int seccion;
    

}

- (IBAction)segmentTop:(UISegmentedControl *)sender;


@property (weak, nonatomic) IBOutlet UITableView *tablaPrograma;
@property (strong,nonatomic) IBOutlet UILabel *identificador;


@end
