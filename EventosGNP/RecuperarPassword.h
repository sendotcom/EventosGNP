//
//  RecuperarPassword.h
//  EventosGNP
//
//  Created by sensey on 06/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"

@interface RecuperarPassword : UIViewController<restDelegate>

- (IBAction)backRecoverPass:(UIButton *)sender;
- (IBAction)backLoginRestorePassword:(UIButton *)sender;
- (IBAction)recuperaPassword:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *campoEmail;

@property (weak, nonatomic) IBOutlet UILabel *recuperaTexto;

@end
