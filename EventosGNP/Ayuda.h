//
//  Ayuda.h
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"

@interface Ayuda : UIViewController<restDelegate>{
    NSMutableArray *ayuda;
}
@property (weak,nonatomic) IBOutlet UIBarButtonItem *menu;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarAyuda;

@property (weak, nonatomic) IBOutlet UITableView *tableViewAyuda;


@end
