//
//  TourInterna.m
//  EventosGNP
//
//  Created by sensey on 17/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "TourInterna.h"

@interface TourInterna ()

@end

@implementation TourInterna

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Poner scroll en el scroll view */
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(320, 740)];
    /* Termina scroll view*/
    
    
    [_tituloTour setText:[_datosTourInterna valueForKey:@"title"]];
    [_fechaTour setText:[_datosTourInterna valueForKey:@"date"]];
    [_horaTour setText:[_datosTourInterna valueForKey:@"time"]];
    [_lugarTour setText:[_datosTourInterna valueForKey:@"location"]];
    [_detallesTour setText:[_datosTourInterna valueForKey:@"details"]];
    
    //_detallesTour.textColor = [UIColor whiteColor];
    
    [_detallesTour setTextColor: [UIColor whiteColor]];
    
    [self ListText];
    

    
   //_linkTour.text=[NSString stringWithFormat:@"%@",[[_datosTourInterna valueForKey:@"links"] valueForKey:@"text"] ];
    
    if ([[[_datosTourInterna valueForKey:@"in_agenda"] stringValue]isEqualToString:@"0"]) {
        [_switchAgendar setOn:NO animated:YES];
    }else{
        [_switchAgendar setOn:YES animated:YES];
    }

    
}

-(NSDate*)stringFecha:(NSString*)fecha{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFromString = [[NSDate alloc] init];

    dateFromString = [dateFormatter dateFromString:fecha];
    
    return dateFromString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



- (IBAction)switchAgendaAccion:(UISwitch *)sender {
    
    if ([sender isOn]) {
        
        NSLog(@"Guardado");
        
        NSString* fechaFin = [_datosTourInterna valueForKey:@"end_date"];
        
        [self guardaActividad:[_datosTourInterna valueForKey:@"title"] fechaInicio:[self stringFecha:[_datosTourInterna valueForKey:@"start_date"]] fechaFin:[self stringFecha:fechaFin]];
        
    }else{
        
        NSLog(@"BORRADO !!!");
        
        /* Cargamos nuestros NSUserDefaults */
        NSUserDefaults *actividad = [NSUserDefaults standardUserDefaults];
        
        [self deleteActividadWithId:[actividad objectForKey:[NSString stringWithFormat:@"idEvento%@",[_datosTourInterna valueForKey:@"id"]]]];
        
        [self llamadaRest];
        
    }
    
}

-(void)guardaActividad:(NSString*)titulo fechaInicio:(NSDate*)fechaInicio fechaFin:(NSDate*)fechaFin{
    
    EKEventStore *store = [EKEventStore new];
    
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        
        
        NSString *dateString = @"28-04-2015";
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *dateFromString = [[NSDate alloc] init];
        // voila!
        dateFromString = [dateFormatter dateFromString:dateString];
        
        
        
        
        // create eventStore object.
        //EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        // create an instance of event with the help of event-store object.
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        
        // set the title of the event.
        event.title = titulo;
        
        event.notes = @"Tour del 28";
        event.location = @"Huatulco";
        
        // set the start date of event - based on current time, tomorrow's date
        event.startDate = dateFromString;
        
        // set the end date - meeting duration 1 hour
        //event.endDate = [[NSDate date] dateByAddingTimeInterval:190000]; // 25 hours * 60 mins * 60 seconds = 86400
        event.endDate = dateFromString;
        
        
        event.allDay = YES;
        // set the calendar of the event. - here default calendar
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        
        // store the event using EventStore.
        NSError *err;
        
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];

        NSLog(@"%@",err);
        NSLog(@"Error From iCal : %@", [err description]);
        
        //EKEvent *event = [EKEvent eventWithEventStore:store];
        
        //event.title = titulo;
        
        //event.startDate = fechaInicio;
        //event.endDate = fechaFin;
        //event.calendar = [store defaultCalendarForNewEvents];
        
        //NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        
        
        
        
        self.identificadorActividad = event.eventIdentifier;
        
        /* Cargamos nuestros NSUserDefaults */
        NSUserDefaults *actividad = [NSUserDefaults standardUserDefaults];
        
        [actividad setValue:self.identificadorActividad forKey:[NSString stringWithFormat:@"idEvento%@",[_datosTourInterna valueForKey:@"id"]]];
        
        [actividad synchronize];
        
        [self llamadaRest];
        
    }];
    
}

-(void)deleteActividadWithId:(NSString*)idActividad{
    
    EKEventStore* store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent* eventToRemove = [store eventWithIdentifier:idActividad];
        if (eventToRemove) {
            NSError* error = nil;
            [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
        }
    }];
}


#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    //NSLog(@"Success");
    
    //NSLog(@"%@",json);
    
    //[_tituloTour setText:@"xD"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTours" object:nil];
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

-(void)llamadaRest{
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    /* Creamos el objeto de REST para actualizar los datos*/
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
   // NSLog(@"%@ %@",info,[_datosTourInterna valueForKey:@"id"]);
    
    [wsRest getAgendaActividad:[info valueForKey:@"id"] idActividad:[_datosTourInterna valueForKey:@"id"] inView:self.view];
    /* Termina creacion de objeto REST */
}
#pragma mark UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    
    
    
    return 1;
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[_datosTourInterna valueForKey:@"images"]count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    //  static NSString *identifier = @"Cell";
    
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentificador" forIndexPath:indexPath];
    
    
    
    
    
    UIImageView *ImageProfile = (UIImageView *)[cell viewWithTag:1];
    
    
    
    [ImageProfile setImageWithURL:[NSURL URLWithString:[[_datosTourInterna valueForKey:@"images"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"regalo"]];
    
    //Cambiar seleccion del ROW
    UIView *bgColorView = [[UIView alloc] init];
    
    bgColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.30];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return [[UICollectionReusableView alloc] init];
    
    
    
}

#pragma mark – UICollectionViewDelegateFlowLayout



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return CGSizeMake(200, 200);
    
}





-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"pulsando item %i",indexPath.row);
}

-(void)ListText{
    NSString *temp=@"";
    
   // NSLog(@"text %@",[_datosTourInterna valueForKey:@"links"]);
    
    for(int i=0;i<[[_datosTourInterna valueForKey:@"links"]count];i++){
        
        //eventName=[[arr2 objectAtIndex:i]objectForKey:@"Code"];
        temp=[temp stringByAppendingString:[[[_datosTourInterna valueForKey:@"links"] valueForKey:@"href"] objectAtIndex:i]];
        
        temp=[temp stringByAppendingString:@" \n"];
    }
    temp = [temp substringToIndex:[temp length]-1];
    
    _linkTour.text= [NSString stringWithFormat:@"%@",temp ];
    
    //[iostextview setText:[NSString stringWithFormat:@"%@",temp ]];
    
    //iostextview.dataDetectorTypes = UIDataDetectorTypeAll;;
}
@end
