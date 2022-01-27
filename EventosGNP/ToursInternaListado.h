//
//  ToursInternaListado.h
//  EventosGNP
//
//  Created by sensey on 17/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"
#import "TourInterna.h"

@interface ToursInternaListado : UIViewController<UITableViewDataSource,UITableViewDelegate,restDelegate>{
    NSMutableArray* datos;
    
    int seleccionado;
}

@property (weak, nonatomic) IBOutlet UITableView *tablaTourInternaListado;
@property(nonatomic,strong)NSString* idEvento;

@end
