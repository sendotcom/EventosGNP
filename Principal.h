//
//  Principal.h
//  EventosGNP
//
//  Created by sensey on 10/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Principal : UIViewController{
    NSMutableArray *info;
}

@property (weak,nonatomic) IBOutlet UIBarButtonItem *menu;

- (IBAction)senderHome:(UITapGestureRecognizer *)sender;


@property (weak, nonatomic) IBOutlet UIImageView *eventoOut;
@property (weak, nonatomic) IBOutlet UIImageView *mensajesOut;

- (IBAction)senderMensaje:(UITapGestureRecognizer *)sender;
- (IBAction)senderNotifica:(UITapGestureRecognizer *)sender;
- (IBAction)senderPerfil:(UITapGestureRecognizer *)sender;
- (IBAction)senderAyuda:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UILabel *nombreAgente;

@end
