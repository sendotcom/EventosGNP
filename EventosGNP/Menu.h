//
//  Menu.h
//  EventosGNP
//
//  Created by sensey on 10/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "Rest.h"
#import <QuartzCore/QuartzCore.h>

@interface Menu : UITableViewController<restDelegate>{
    
    NSMutableArray *info;
    NSString *contadorTotal;
    

}
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UILabel *nameProfile;



@end
