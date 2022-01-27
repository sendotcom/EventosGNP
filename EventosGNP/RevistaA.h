//
//  RevistaA.h
//  EventosGNP
//
//  Created by sensey on 02/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"

@interface RevistaA : UIViewController<restDelegate>{
      NSMutableArray *info;
}
@property (weak, nonatomic) IBOutlet UIImageView *imagenRevista;

@end
