//
//  Tours.m
//  EventosGNP
//
//  Created by sensey on 15/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Tours.h"
#import "Rest.h"

@interface Tours ()

@end

@implementation Tours

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadTours:) name:@"ReloadTours" object:nil];

    [self getTours];
}


-(void)viewDidAppear:(BOOL)animated{

    _tablaVista.contentInset = UIEdgeInsetsZero;
    
    [super viewDidAppear:NO];
    
    //Linea para customizar el boton regresar
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    //Color de al texto e la navigation Bar
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    //Titulo del Navigation bar
    self.navigationController.navigationBar.topItem.title = @"TOURS";
    //Estilos del titulo del navigation BAR
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName,
                                                                   [UIFont fontWithName:@"Roboto" size:24.0], NSFontAttributeName,nil];
     
    
    
}

-(void)tabla{
    
    
    NSArray *array = [_names allKeys];
    self.keys = array;

}

-(void)ReloadTours:(NSNotification *)notificacion{
    [self getTours];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getTours{
    
    int aidi = 2 ;
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    /* Armamos la URL de peticion para el servicio*/
    peticion = @"http://eventos.appsgnp.mx/api/evento/actividades/";
    
    // Concatenacion
    peticion = [NSString stringWithFormat:@"%@%d/%@", peticion,aidi,[info valueForKey:@"id"]];
    /* Termina URL peticion */
    
    NSLog(@"%@",peticion);
    
    /* Creamos el objeto de REST para actualizar los datos*/
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    [wsRest restPostUrl:peticion withDic:[wsRest getDatos]inView:self.view];
    /* Termina creacion de objeto REST */
    
    wsRest.delegate = self;
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TourInterna *tourInternaInstancia = [segue destinationViewController];
    
    tourInternaInstancia.datosTourInterna = [informacionTourInterna objectAtIndex:seleccionada];
}

#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //Specifies the number of sections.
    
    return [_grupo count];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[_grupo valueForKey:@"activities"] objectAtIndex:section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSString *key = [_keys objectAtIndex:indexPath.section];
    
    //NSArray *name = [_names objectForKey:key];
    
   // _tablaVista.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tablaVista.bounds.size.width, 0.01f)];

    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.textLabel.textColor = [UIColor whiteColor];

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    [cell.textLabel setText:[[[[_grupo valueForKey:@"activities"] objectAtIndex:0] objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    NSString *key = [[_grupo valueForKey:@"date"] objectAtIndex:section];
    
    
    
    return key;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    seleccionada = indexPath.row;
    
    //NSLog(@"%d",seleccionada);
    
    [self performSegueWithIdentifier:@"pushTourInterna" sender:self];
    
    //[self rowTouch:indexPath.row];
}

-(void)rowTouch:(NSInteger)Celda{
    
    //[self performSegueWithIdentifier:@"tipoA" sender:self];
    
    // NSLog(@"Tocada");
    
}

-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        UIView* content = castView.contentView;
        UIColor* color = [UIColor colorWithWhite:0.85 alpha:0.6]; // substitute your color here
        content.backgroundColor = color;
        
        [castView.textLabel setTextColor:[UIColor whiteColor]];
        
    }
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
   
    
    _grupo = [[NSMutableArray alloc] init];
    
    _grupo = [json valueForKey:@"list"];
    informacionTourInterna = [[_grupo valueForKey:@"activities"] objectAtIndex:0];
    
     NSLog(@"%@",json);
    [self.tablaVista reloadData];
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

@end
