//
//  Ayuda.m
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Ayuda.h"
#import "SWRevealViewController.h"
#import "Rest.h"

@interface Ayuda ()

@end

@implementation Ayuda

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getAyuda];
    
    _menu.target = self.revealViewController;
    _menu.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
        
    [self setTitle:@"AYUDA"];
    
    
}

-(void)getAyuda{
    Rest* rest = [[Rest alloc]init];
    
    rest.delegate = self;
    
    [rest restPostUrl:@"http://eventos.appsgnp.mx/api/ayuda" withDic:[rest getAyuda:@""]inView:self.view];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.font = [UIFont fontWithName:@"Roboto" size:24.0];
        titleView.textColor = [UIColor orangeColor];
        
        self.navigationItem.titleView = titleView;
        
    }
    titleView.text = title;
    [titleView sizeToFit];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [ayuda count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSString *cellIdentificador = [menu objectAtIndex:indexPath.row];
    
    static NSString* cellIdentifier = @"celdaAyuda";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
   
    UILabel *nombre = (UILabel*)[cell viewWithTag:1];
    UITextView *correo = (UITextView*)[cell viewWithTag:2];
    UILabel *telefono = (UILabel*)[cell viewWithTag:3];
    UILabel *equipo = (UILabel*)[cell viewWithTag:4];
    UILabel *zona = (UILabel*)[cell viewWithTag:5];
    UILabel *area = (UILabel*)[cell viewWithTag:6];
    
  
    
    [nombre setText:[[ayuda objectAtIndex:indexPath.row] valueForKey:@"name"]];
    [correo setText:[[ayuda objectAtIndex:indexPath.row] valueForKey:@"email"]];
    [telefono setText:[[ayuda objectAtIndex:indexPath.row] valueForKey:@"phone"]];
    [equipo setText:[[ayuda objectAtIndex:indexPath.row] valueForKey:@"group"]];
    [zona setText:[[ayuda objectAtIndex:indexPath.row] valueForKey:@"location"]];
    [area setText:[[ayuda objectAtIndex:indexPath.row] valueForKey:@"area"]];
    
    //correo.dataDetectorTypes = UIDataDetectorTypeAll;
    
    //Cambiar seleccion del ROW
    UIView *bgColorView = [[UIView alloc] init];
    
    bgColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.30];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:iliana.martinez@gnp.com.mx"]];
    
   // NSLog(@"TEST");
    
}




#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
    // NSLog(@"%@",json);
    
    ayuda = [[NSMutableArray alloc] initWithArray:[json valueForKey:@"list"]];
    
    [self.tableViewAyuda reloadData];
    //[self AlertaShow:[json valueForKey:@"message"]];
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

@end
