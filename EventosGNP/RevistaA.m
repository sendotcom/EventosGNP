//
//  RevistaA.m
//  EventosGNP
//
//  Created by sensey on 02/04/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "RevistaA.h"
#import "UIImageView+AFNetworking.h"

@interface RevistaA ()

@end

@implementation RevistaA

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    [wsRest restPostUrl:@"http://gnpapp.desarrollosmasclicks.com/api/revista/2" withDic:[wsRest getRevista] inView:self.view];
    

    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:NO];
    
    //Linea para customizar el boton regresar
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    //Color de al texto e la navigation Bar
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    //Titulo del Navigation bar
    self.navigationController.navigationBar.topItem.title = @"REVISTA";
    //Estilos del titulo del navigation BAR
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName,
                                                                   [UIFont fontWithName:@"Roboto" size:24.0], NSFontAttributeName,nil];
    
    
    
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

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{
    
     NSLog(@"Succes en Revista: %@",json);
    
    info = json;
    
    NSLog(@"%@",[json valueForKey:@"image"]);
    
    [self.imagenRevista setImageWithURL:[NSURL URLWithString:[info valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"perfil_temporal.png"]];
    
    //ayuda = [[NSMutableArray alloc] initWithArray:[json valueForKey:@"list"]];
    
    //NSLog(@"Ayuda:: %@ ",ayuda);
    //[self.tableViewAyuda reloadData];
    //[self AlertaShow:[json valueForKey:@"message"]];
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

@end
