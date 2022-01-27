//
//  Programa.m
//  EventosGNP
//
//  Created by sensey on 10/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Programa.h"

@interface Programa ()

@end

@implementation Programa

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.parentViewController.navigationItem.title = @"sdfsdf.";
    
    selected = NO;
    
    [self getPrograma];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:NO];
    
    //Linea para customizar el boton regresar
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    //Color de al texto e la navigation Bar
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    //Titulo del Navigation bar
    self.navigationController.navigationBar.topItem.title = @"PROGRAMA";
    //Estilos del titulo del navigation BAR
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName,
                                                                   [UIFont fontWithName:@"Roboto" size:24.0], NSFontAttributeName,nil];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if(seccion == 1){
        
        ProgramaInterna *programa = [segue destinationViewController];
        programa.datos = [eventos objectAtIndex:seleccion];
        
    }else{
        
        TourInterna *tourInternaInstancia = [segue destinationViewController];
        tourInternaInstancia.datosTourInterna = [agendadas objectAtIndex:seleccion];
        
    }
}


-(void)getPrograma{
    
    tipoServicio = NO;
    
    Rest* rest = [[Rest alloc]init];
    rest.delegate = self;

    [rest getProgramas:self.view];
    
    
}

-(void)getAgendadas{
    
     tipoServicio = YES;
    
    Rest* rest = [[Rest alloc]init];
    rest.delegate = self;
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    [rest getActividadesAgendadasPorUsuario:[info valueForKey:@"id"] inView:self.view];
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!selected) {
        return [eventos count];
    } else {
        return [agendadas count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* actividadesCell = @"actividadesCell";
    static NSString* cellIdentifier = @"programaTV";
    
    UITableViewCell *cell;
    

    
    if (!selected) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        UILabel *dia = (UILabel*)[cell viewWithTag:1];
        UILabel *diaTxt = (UILabel*)[cell viewWithTag:2];
        UILabel *mes = (UILabel*)[cell viewWithTag:3];
        
        _identificador = (UILabel*)[cell viewWithTag:5];
        
        
        [dia setText:[[eventos objectAtIndex:indexPath.row] valueForKey:@"day_number"]];
        [diaTxt setText:[[eventos objectAtIndex:indexPath.row] valueForKey:@"day"]];
        [mes setText:[[eventos objectAtIndex:indexPath.row] valueForKey:@"month"]];
        
        NSString *ai = [[eventos objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        [_identificador setText:[NSString stringWithFormat:@"%@",ai]];
        
       
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:actividadesCell forIndexPath:indexPath];
        
        UILabel *titulo = (UILabel*)[cell viewWithTag:1];
        UILabel *fecha = (UILabel*)[cell viewWithTag:2];
        UILabel *lugar = (UILabel*)[cell viewWithTag:3];
        UILabel *time = (UILabel*)[cell viewWithTag:4];

        [titulo setText: [[agendadas objectAtIndex:indexPath.row] valueForKey:@"title"]];
        [fecha setText: [[agendadas objectAtIndex:indexPath.row] valueForKey:@"date"]];
        [lugar setText: [[agendadas objectAtIndex:indexPath.row] valueForKey:@"location"]];
        [time setText: [[agendadas objectAtIndex:indexPath.row] valueForKey:@"time"]];

        
        NSLog(@"%@",[[agendadas objectAtIndex:indexPath.row] valueForKey:@"title"]);
        
    }
    
    //Cambiar seleccion del ROW
    UIView *bgColorView = [[UIView alloc] init];
    
    bgColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.30];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!selected) {
        
        NSString *clase = [[NSString alloc] init];
        NSString *ai = [[eventos objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        [_identificador setText:[NSString stringWithFormat:@"%@",ai]];
        
        clase = [[eventos objectAtIndex:indexPath.row] valueForKey:@"class"];
        
        seccion = 1;
        seleccion = indexPath.row;
        
        [self performSegueWithIdentifier:@"pushPrograma" sender:self];
        
    } else {
        
        seccion = 2;
        seleccion = indexPath.row;
        
        NSString *idTour = [[agendadas objectAtIndex:indexPath.row] valueForKey:@"id"];
        
        [self performSegueWithIdentifier:@"pushAgendadas" sender:self];
        //NSLog(@"ID TOUR: %@",idTour);
        
        
    }
    

    

}

-(void)rowTouch:(NSInteger)Celda{
    
    //[self performSegueWithIdentifier:@"tipoA" sender:self];
    
    // NSLog(@"Tocada");
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    if(!tipoServicio){
        
        eventos = [[NSMutableArray alloc] initWithArray:[json valueForKey:@"schedule"]];

    }else{
        
        agendadas =[[NSMutableArray alloc] initWithArray:[json valueForKey:@"list"]];
    
    }
    
    [_tablaPrograma reloadData];
    
    //[self AlertaShow:[json valueForKey:@"message"]];
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}


- (IBAction)segmentTop:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex==0){
        
        [self getPrograma];
        
        selected = NO;
    }else{
        [self getAgendadas];
        
        selected = YES;
    }
    
    [_tablaPrograma reloadData];
}
@end
