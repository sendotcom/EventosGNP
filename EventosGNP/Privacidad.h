//
//  Privacidad.h
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"

@interface Privacidad : UIViewController<restDelegate>

@property (weak,nonatomic) IBOutlet UIBarButtonItem *menu;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewPrivacidad;
@property (weak, nonatomic) IBOutlet UILabel *privacidadOutlet;
@property (weak, nonatomic) IBOutlet UILabel *tituloPrivacidadOutlet;
@property (weak, nonatomic) IBOutlet UIWebView *webPrivacidad;

@end
