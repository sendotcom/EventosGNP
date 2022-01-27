//
//  ViewController.h
//  Servicios
//
//  Created by sensey on 03/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rest.h"
#import <Parse/Parse.h>

@interface ViewController : UIViewController <restDelegate>{
    
    __weak IBOutlet UITextField *userTxt;
    __weak IBOutlet UITextField *passwordTxt;
    __weak IBOutlet UILabel *errorLabel;
    
}

- (IBAction)login:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *mensajeErrorTxt;
@property (weak, nonatomic) IBOutlet UIImageView *imgError;

@end

