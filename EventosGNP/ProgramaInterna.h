//
//  ProgramaInterna.h
//  EventosGNP
//
//  Created by sensey on 11/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToursInternaListado.h"

@interface ProgramaInterna : UIViewController{
    int seleccionado;
}
@property (weak, nonatomic) IBOutlet UILabel *fecha;
@property (weak, nonatomic) IBOutlet UITableView *tablaPrograma;
@property(strong,nonatomic) NSMutableArray* datos;

@end
