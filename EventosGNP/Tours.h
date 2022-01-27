//
//  Tours.h
//  EventosGNP
//
//  Created by sensey on 15/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"
#import "TourInterna.h"

@interface Tours : UIViewController <restDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    NSString* peticion;
    NSMutableArray* informacionTourInterna;
    
    long total;
    int seleccionada;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tablaVista;

@property (strong, nonatomic) NSDictionary *names;
@property (strong, nonatomic) NSMutableArray *grupo;
@property (strong, nonatomic) NSArray *keys;


@end
