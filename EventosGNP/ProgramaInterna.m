//
//  ProgramaInterna.m
//  EventosGNP
//
//  Created by sensey on 11/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "ProgramaInterna.h"

@interface ProgramaInterna ()

@end

@implementation ProgramaInterna

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_fecha setText:[self.datos valueForKey:@"date"]];
    
    NSLog(@"Datos: %@",_datos);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ToursInternaListado *actividadTour = [segue destinationViewController];
    
    //NSLog(@"%@",[[[[self.datos valueForKey:@"activities"] objectAtIndex:seleccionado] valueForKey:@"id"] stringValue]);
    
    actividadTour.idEvento = [[[[self.datos valueForKey:@"activities"] objectAtIndex:seleccionado] valueForKey:@"id"] stringValue];
    
    
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.datos valueForKey:@"activities"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSString *cellIdentificador = [menu objectAtIndex:indexPath.row];
    
    
    static NSString* cellIdentifier = @"programaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //UIImageView *equipo = (UIImageView*)[cell viewWithTag:1];
    
    //[equipo setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    
    if([[[[[self.datos valueForKey:@"activities"] objectAtIndex:indexPath.row] valueForKey:@"has_activities"] stringValue] isEqualToString:@"1"]){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else{
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    UILabel *titulo = (UILabel*)[cell viewWithTag:1];
    UILabel *locacion = (UILabel*)[cell viewWithTag:2];
    UILabel *hora = (UILabel*)[cell viewWithTag:3];
    
    [titulo setText:[[[self.datos valueForKey:@"activities"] objectAtIndex:indexPath.row] valueForKey:@"title"]];
    [locacion setText:[[[self.datos valueForKey:@"activities"] objectAtIndex:indexPath.row] valueForKey:@"location"]];
    [hora setText:[[[self.datos valueForKey:@"activities"] objectAtIndex:indexPath.row] valueForKey:@"time"]];
    
    //Cambiar seleccion del ROW
    UIView *bgColorView = [[UIView alloc] init];
    
    bgColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.30];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    seleccionado = indexPath.row;
    
    if([[[[[self.datos valueForKey:@"activities"] objectAtIndex:indexPath.row] valueForKey:@"has_activities"] stringValue] isEqualToString:@"1"]){
        
        
        [self performSegueWithIdentifier:@"pushHashActivities" sender:self];
        
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else{
       // cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
}

-(void)rowTouch:(NSInteger)Celda{
    
    //[self performSegueWithIdentifier:@"tipoA" sender:self];
    
    // NSLog(@"Tocada");
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}


@end
