//
//  Sede.m
//  EventosGNP
//
//  Created by sensey on 06/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Sede.h"
#import "UIImageView+AFNetworking.h"
#import <MapKit/MapKit.h>

@interface Sede ()

@end

@implementation Sede


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_sedeScrollView setScrollEnabled:YES];
    
    [[_verHotelBoton layer] setBorderWidth:2.0f];
    [[_verHotelBoton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    
    [self cargaInfoEvento];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:NO];
    
    //Linea para customizar el boton regresar
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    //Color de al texto e la navigation Bar
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    //Titulo del Navigation bar
    self.navigationController.navigationBar.topItem.title = @"SEDE";
    //Estilos del titulo del navigation BAR
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Roboto" size:24.0], NSFontAttributeName,nil];
    
}



- (void)setTitleTop:(NSString *)title{
    
    //[super setTitle:title];
    
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    titleView.font = [UIFont fontWithName:@"Roboto" size:24.0];
    
    titleView.textColor = [UIColor orangeColor];
    
    self.navigationItem.titleView = titleView;
    
    //self.navigationController.navigationBar.topItem.title = titleView;
    
    titleView.text = title;
    
    [titleView sizeToFit];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)seteaIdentificador:(NSString *)ident{
    
    
    
    /*
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    NSLog(@"%@",ident);
    
    NSString *aidi = ident;
    

    NSString *peticion = @"http://gnpapp.desarrollosmasclicks.com/api/eventos/";
    
    // Concatenacion
    peticion = [NSString stringWithFormat:@"%@%@", peticion,aidi];


    
    
    [wsRest restPostUrl:peticion withDic:[wsRest getEvento] inView:self.view];
    
    identificadorLocal = ident;
    
    NSLog(@"%@",ident);
    
    NSLog(@" ENTRA AL METODO: %@",ident);
     
    */
}

- (void)cargaInfoEvento{
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString * ident = [ud valueForKey:@"eventoID"];
    
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    NSLog(@"%@",ident);
    
    NSString *aidi = ident;
    
    NSString *peticion = @"http://eventos.appsgnp.mx/api/eventos/";
    
    // Concatenacion
    peticion = [NSString stringWithFormat:@"%@%@", peticion,aidi];
    
    [wsRest restPostUrl:peticion withDic:[wsRest getEvento] inView:self.view];
    
    identificadorLocal = ident;
    
    //NSLog(@"%@",ident);
    
    //NSLog(@" ENTRA AL METODO: %@",ident);
    
}

-(void)success:(NSMutableArray*)json{
    
    // eventoLiga = @"http://www.facebook.com";
    //NSLog(@"%@",json);
    
    infoEvento = json;
    
    [self setInfo];
    
    [self.imgEvento setImageWithURL:[NSURL URLWithString:[infoEvento valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
     [self.diaEvento setText:[infoEvento valueForKey:@"date_formated"]];
     [self.nombreEvento setText:[infoEvento valueForKey:@"name"]];
     [self.eventoDireccion setText:[infoEvento valueForKey:@"address_formated"]];
     [self.eventoIntro setText:[infoEvento valueForKey:@"intro"]];
    
    
     [self.eventoDescripcion setText:[infoEvento valueForKey:@"content"]];
    
    
    
     [self.eventoDIa setText:[infoEvento valueForKey:@"day"]];
    
      [self.eventoImagenClima setImageWithURL:[NSURL URLWithString:[infoEvento valueForKey:@"weather_image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
    [self.climaMin setText:[infoEvento valueForKey:@"min_temp"]];
    [self.climaMax setText:[infoEvento valueForKey:@"max_temp"]];
    
    eventoLiga = [infoEvento valueForKey:@"weather_link"];
    eventoHotel = [infoEvento valueForKey:@"link"];
    
    //[_eventoDescripcion sizeToFit];
    
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [_eventoDescripcion.text sizeWithFont:_eventoDescripcion.font constrainedToSize:maximumLabelSize lineBreakMode:_eventoDescripcion.lineBreakMode];
    
    //adjust the label the the new height.
    CGRect newFrame = _eventoDescripcion.frame;
    newFrame.size.height = expectedLabelSize.height;
    
    _eventoDescripcion.frame = newFrame;
    
    [_sedeScrollView setContentSize:CGSizeMake(320,(_eventoIntro.frame.size.height+_eventoDescripcion.frame.size.height+50))];
    

    
}

-(void) setInfo{
    self.diaEvento.text = @"NPI";
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)verHotel {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eventoHotel]];
}

- (IBAction)eventoLiga:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eventoLiga]];
}
@end
