//
//  TourInterna.h
//  EventosGNP
//
//  Created by sensey on 17/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "Rest.h"
#import "ToursInternaListado.h"
#import "UIImageView+AFNetworking.h"

@interface TourInterna : UIViewController<restDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UISwitch *switchAgendar;

@property(strong,nonatomic) NSMutableArray* datosTourInterna;
@property(strong,nonatomic) NSString* identificadorActividad;

@property (weak, nonatomic) IBOutlet UILabel *tituloTour;
@property (weak, nonatomic) IBOutlet UILabel *fechaTour;
@property (weak, nonatomic) IBOutlet UILabel *horaTour;
@property (weak, nonatomic) IBOutlet UILabel *lugarTour;


@property (weak, nonatomic) IBOutlet UITextView *detallesTour;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionOutlet;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *linkTour;

- (IBAction)switchAgendaAccion:(UISwitch *)sender;
@end
