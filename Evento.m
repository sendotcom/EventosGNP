//
//  Evento.m
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Evento.h"
#import "SWRevealViewController.h"


@interface Evento ()

@end

@implementation Evento

- (void)viewDidLoad {
    [super viewDidLoad];

    _menu.target = self.revealViewController;
    _menu.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self getEventos];
    
    [self setTitle:@"EVENTOS"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
    if (tipo) {
        
        
        NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
        [uf setValue:_identificador.text forKey:@"eventoID"];
        
        
        
    }else{
        
        NSUserDefaults *uf = [NSUserDefaults standardUserDefaults];
        
        [uf setValue:_identificador.text forKey:@"eventoID"];
        //TipoA *type = [segue destinationViewController];
        
        //NSLog(@"%@",_identificador.text);
        
        //type.ideLocal = _identificador.text;
    }
    
    
    
   // [sede seteaIdentificador:_identificador.text];
    
   // sede setIdentificador:[UILabel ]
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getEventos{
    
    Rest* rest = [[Rest alloc]init];
    
    rest.delegate = self;
    
    [rest getEventos:self.view];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [eventos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSString *cellIdentificador = [menu objectAtIndex:indexPath.row];
    
    static NSString* cellIdentifier = @"eventosTV";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImageView *equipo = (UIImageView*)[cell viewWithTag:1];
    
    //[equipo setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    
    UILabel *nombre = (UILabel*)[cell viewWithTag:2];
    UILabel *correo = (UILabel*)[cell viewWithTag:3];
    
    UILabel *telefono = (UILabel*)[cell viewWithTag:4];
    
    _identificador = (UILabel*)[cell viewWithTag:5];

    //NSLog(@"%@",eventos);
    
    [nombre setText:[[eventos objectAtIndex:indexPath.row] valueForKey:@"name"]];
    [correo setText:[[eventos objectAtIndex:indexPath.row] valueForKey:@"date_formated"]];
    
    [telefono setText:[[eventos objectAtIndex:indexPath.row] valueForKey:@"phone"]];
    
    NSString *ai = [[eventos objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    //NSLog(@"%@",ai);
    
    [_identificador setText:[NSString stringWithFormat:@"%@",ai]];
    
    [equipo setImageWithURL:[NSURL URLWithString:[[eventos objectAtIndex:indexPath.row] valueForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"generica-1.jpg"]];
    
    
    
    
    //[txt setText:[texto objectAtIndex:indexPath.row]];
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   // NSLog(@"El evento Seleccionado %@",[[eventos objectAtIndex:indexPath.row] valueForKey:@"name"]);
    
    //int x = [[eventos objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    NSString *clase = [[NSString alloc] init];
    
    NSString *ai = [[eventos objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    [_identificador setText:[NSString stringWithFormat:@"%@",ai]];

    clase = [[eventos objectAtIndex:indexPath.row] valueForKey:@"class"];
    
    if([clase isEqualToString:@"a"]){
        
        tipo = YES;
        
        [self performSegueWithIdentifier:@"tipoA" sender:self];
       
        //NSLog(@"No envio");
        
    }else{
        tipo = NO;
        [self performSegueWithIdentifier:@"tipoB" sender:self];
    }
    
    //[self rowTouch:indexPath.row];
}

-(void)rowTouch:(NSInteger)Celda{
    
    //[self performSegueWithIdentifier:@"tipoA" sender:self];
    
   // NSLog(@"Tocada");

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    //NSLog(@"%@",json);
    
    eventos = [[NSMutableArray alloc] initWithArray:[json valueForKey:@"list"]];
    
    //NSLog(@"Ayuda:: %@ ",ayuda);
    [self.tablaVista reloadData];
    //[self AlertaShow:[json valueForKey:@"message"]];
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}


@end
