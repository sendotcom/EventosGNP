//
//  Notificaciones.m
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Notificaciones.h"
#import "SWRevealViewController.h"

@interface Notificaciones ()

@end

@implementation Notificaciones

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menu.target = self.revealViewController;
    _menu.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self setTitle:@"NOTIFICACIONES"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self getNotificacion];
}

#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    NotificacionInterna *notificacionSimple = [segue destinationViewController];
    
    NSLog(@"Notificacion leida: %@",[_notificaLista objectAtIndex:seleccion]);
    
    //NSMutableArray *notificacionDePaso = [[NSMutableArray alloc]initWithArray:[_notificaLista objectAtIndex:seleccion]];
    
    //NSLog(@"%@",notificacionDePaso);
    
   // NSLog(@"ARRIBA: %d",seleccion);
    
    notificacionSimple.datosNotificacionInterna = [_notificaLista objectAtIndex:seleccion];
    
    //notificacionSimple.datosInterna = [_notificaLista objectAtIndex:seleccion];

    
    
    
    
}

- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    titleView.font = [UIFont fontWithName:@"Roboto" size:24.0];
    
    titleView.textColor = [UIColor orangeColor];
    
    self.navigationItem.titleView = titleView;
    
    titleView.text = title;
    
    [titleView sizeToFit];
}


-(void)getNotificacion{
    
    Rest* rest = [[Rest alloc]init];
    rest.delegate = self;
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    [rest getNotificaciones:[info valueForKey:@"id"] inView:self.view];
    
    rest.delegate = self;
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_notificaLista count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString* cellIdentifier = @"notificacionesCell";
    
    UITableViewCell *cell;
    
   // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        UILabel *notificacionNombre = (UILabel*)[cell viewWithTag:1];
        UILabel *notificacionHora = (UILabel*)[cell viewWithTag:2];
    
        UIImageView *notificacionBullet = (UIImageView*)[self.view viewWithTag:3];
    
    
        [notificacionNombre setText:[[_notificaLista objectAtIndex:indexPath.row] valueForKey:@"short_text"]];
        [notificacionHora setText:[[_notificaLista objectAtIndex:indexPath.row] valueForKey:@"time"]];
    
        if ([[[[_notificaLista objectAtIndex:indexPath.row] valueForKey:@"read"] stringValue] isEqualToString:@"1"]) {
            
           [notificacionBullet setHidden:YES];
            
        }
    
    //Cambiar seleccion del ROW
    UIView *bgColorView = [[UIView alloc] init];
    
    bgColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.30];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    seleccion = indexPath.row;
    
    [self performSegueWithIdentifier:@"pushNotificacionInterna" sender:self];
    
    
}

-(void)rowTouch:(NSInteger)Celda{
    
    //[self performSegueWithIdentifier:@"tipoA" sender:self];
    
    // NSLog(@"Tocada");
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    NSLog(@"%@",json);
    
   // NSLog(@"VALOR EN TOTAL : %@",[json valueForKey:@"total"]);
    
    int total = [[json valueForKey:@"total"] intValue];
    
    if(total > 0){
        
        _notificaLista = [[[NSMutableArray alloc] initWithArray:[[json valueForKey:@"list"] valueForKey:@"notifications"]] objectAtIndex:0];
        
        [_tablaNotificaciones reloadData];
        
    }else{
        
        [self AlertaShow:@"No tienes notificaciones"];
        
    }

   
    
    
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

-(void)AlertaShow:(NSString*)Text{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:Text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}



@end