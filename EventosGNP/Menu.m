//
//  Menu.m
//  EventosGNP
//
//  Created by sensey on 10/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Menu.h"
#import "SWRevealViewController.h"

@interface Menu ()

@end

@implementation Menu{
    NSArray *menu,*texto,*imagenes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNotificacion];
    //[self infoProfile];
    
    menu = @[@"home",@"evento",@"notificaciones",@"perfil",@"ayuda",@"privacidad",@"logout"];
    
    texto = @[@"HOME",@"EVENTOS",@"NOTIFICACIONES",@"PERFIL",@"AYUDA",@"PRIVACIDAD",@"SALIR"];
    
    imagenes = @[@"menu-home.png",@"menu-eventos.png",@"menu-notificaciones.png",@"menu-perfil",@"menu-ayuda.png",@"menu-aviso.png",@"menu-cerrar.png"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(abrirImagen:)];
    
    _imageProfile.userInteractionEnabled = YES;
    
    [_imageProfile addGestureRecognizer:tap];

}

-(void)abrirImagen:(UITapGestureRecognizer *) gestureRecognizer {
    NSLog(@"CLIQUEABLE");
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
   // NSLog(@"%@",info);
    
    //NSLog(@"%@",info);
    
    //NSLog(@"%@",[def valueForKey:@"fullName"]);
    
    if([def valueForKey:@"image"] == nil){
        
         [self.imageProfile setImageWithURL:[NSURL URLWithString:[info valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
        
        
        //[self.nameProfile setText:@"Prueba"];
    }else{
        
        
        //[self.nameProfile setText:[def valueForKey:@"fullName"]];
      
        [self.imageProfile setImageWithURL:[NSURL URLWithString:[def valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
    }
    [self infoProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)getNotificacion{
    
    Rest* rest = [[Rest alloc]init];
    rest.delegate = self;
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * infoMenu = [[NSMutableArray alloc] init];
    infoMenu = [defaults objectForKey:@"Info"];
    
    [rest getNotificaciones:[infoMenu valueForKey:@"id"] inView:self.view];
    
    rest.delegate = self;
    
}


-(void)infoProfile{
 
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    self.imageProfile.layer.cornerRadius = self.imageProfile.frame.size.width / 2;
    self.imageProfile.clipsToBounds = YES;
        
    [self.imageProfile setImageWithURL:[NSURL URLWithString:[info valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
    [self.nameProfile setText:[info valueForKey:@"fullName"]];
  
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"celda";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    //Cambiar seleccion del ROW
    UIView *bgColorView = [[UIView alloc] init];

    bgColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.50];
    [cell setSelectedBackgroundView:bgColorView];
    
    //cell.contentView.backgroundColor = [UIColor yellowColor];

    
    UIImageView *iconos = (UIImageView*)[cell viewWithTag:1];
    [iconos setImage:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.row]]];
    
    UILabel *txt = (UILabel*)[cell viewWithTag:2];
    [txt setText:[texto objectAtIndex:indexPath.row]];
    
    UILabel *contadorNotificacion = (UILabel*)[cell viewWithTag:3];
    UILabel *imagenCampana = (UILabel*)[cell viewWithTag:4];
    
    if(indexPath.row == 2){
        [contadorNotificacion setHidden:NO];
        [contadorNotificacion setText:contadorTotal];
        
        [imagenCampana setHidden:NO];
    }else{
        [contadorNotificacion setHidden:YES];
    }
    
    //[txt setText:[texto objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self rowTouch:indexPath.row];
    
}


-(void)rowTouch:(NSInteger)Celda{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *datos = [NSMutableDictionary new];
    
    switch (Celda) {
        case 0:
            [self performSegueWithIdentifier:@"pushHome" sender:self];
        break;
        
        case 1:
            [self performSegueWithIdentifier:@"pushEvento" sender:self];
        break;
            
        case 2:
            [self performSegueWithIdentifier:@"pushNotificaciones" sender:self];
        break;
            
        case 3:
            [self performSegueWithIdentifier:@"pushPerfil" sender:self];
        break;
            
        case 4:
            [self performSegueWithIdentifier:@"pushAyuda" sender:self];
        break;
            
        case 5:
            [self performSegueWithIdentifier:@"pushPrivacidad" sender:self];
        break;
            
        case 6:
            
            [datos setValue:@"0" forKey:@"valid"];
            
            [defaults setValue:datos forKey:@"json"];
            [defaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        break;
            
        default:
        
        break;
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if([segue isKindOfClass:[SWRevealViewControllerSegue class]] ){
        
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc){
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers:@[dvc] animated:NO];
            
            [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
            
        };
    }
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    contadorTotal = [[json valueForKey:@"unread"] stringValue];
    
    [self.tableView reloadData];

}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}
@end