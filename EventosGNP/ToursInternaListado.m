//
//  ToursInternaListado.m
//  EventosGNP
//
//  Created by sensey on 17/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "ToursInternaListado.h"

@interface ToursInternaListado ()

@end

@implementation ToursInternaListado

- (void)viewDidLoad {
    [super viewDidLoad];
    [self llamadaRest];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TourInterna *tourInternaInstancia = [segue destinationViewController];
    
    tourInternaInstancia.datosTourInterna = [datos objectAtIndex:seleccionado];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
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

-(void)llamadaRest{
    
    /* Cargamos nuestros NSUserDefaults */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * info = [[NSMutableArray alloc] init];
    info = [defaults objectForKey:@"Info"];
    
    /* Creamos el objeto de REST para actualizar los datos*/
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    // NSLog(@"%@ %@",info,[_datosTourInterna valueForKey:@"id"]);
    
    [wsRest getActividadesPrograma:_idEvento idActividad:[info valueForKey:@"id"] inView:self.view];
    
    /* Termina creacion de objeto REST */
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSString *cellIdentificador = [menu objectAtIndex:indexPath.row];
    
    
    static NSString* cellIdentifier = @"cellToursInterna";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //UIImageView *equipo = (UIImageView*)[cell viewWithTag:1];
    
    //[equipo setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UISwitch *switchInterna =(UISwitch*)[cell viewWithTag:2];
    [switchInterna setTag:indexPath.row];
    
    
    [switchInterna addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    
    
    UILabel *titulo = (UILabel*)[cell viewWithTag:1];
    
    
    [titulo setText:[[datos valueForKey:@"title"] objectAtIndex:indexPath.row]];
      
    //Cambiar seleccion del ROW
    UIView *bgColorView = [[UIView alloc] init];
    
    bgColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.30];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}

- (IBAction) flip: (UISwitch*) sender {
    
    NSLog(@"%li",(long)sender.tag);
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    seleccionado = indexPath.row;
    
    [self performSegueWithIdentifier:@"pushTourInterna2" sender:self];
}

-(void)rowTouch:(NSInteger)Celda{
    
    //[self performSegueWithIdentifier:@"tipoA" sender:self];
    
    // NSLog(@"Tocada");
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    datos = [[NSMutableArray alloc]init];
    datos = [json valueForKey:@"list"];
    
    [_tablaTourInternaListado reloadData];

}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}
@end
