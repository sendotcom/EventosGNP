//
//  Privacidad.m
//  EventosGNP
//
//  Created by sensey on 17/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Privacidad.h"
#import "SWRevealViewController.h"

@interface Privacidad ()

@end

@implementation Privacidad

@synthesize scrollViewPrivacidad;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fullURL = @"http://eventos.appsgnp.mx/api/privacidad-html";
    
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [_webPrivacidad setBackgroundColor:[UIColor orangeColor]];
        
    [_webPrivacidad setBackgroundColor:[UIColor colorWithRed:240/255.0 green:136/255.0 blue:59/255.0 alpha:1.0]];
    [_webPrivacidad setOpaque:NO];
    [_webPrivacidad loadRequest:requestObj];
    
    _webPrivacidad.dataDetectorTypes = UIDataDetectorTypeNone;
    
    [scrollViewPrivacidad setScrollEnabled:YES];
    [scrollViewPrivacidad setContentSize:CGSizeMake(320,1500)];
    
    Rest* wsRest = [[Rest alloc] init];
    
    wsRest.delegate = self;
    
    [wsRest restPostUrl:@"http://gnpapp.desarrollosmasclicks.com/api/privacidad" withDic:[wsRest getPrivacidad] inView:self.view];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [self setTitle:@"PRIVACIDAD"];
   
    _menu.target = self.revealViewController;
    _menu.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
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

- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        
        titleView = [[UILabel alloc] initWithFrame:CGRectNull];
        
        titleView.font = [UIFont fontWithName:@"Roboto" size:23.0];
        titleView.textColor = [UIColor orangeColor];
        
        self.navigationItem.titleView = titleView;
        
    }
    titleView.text = title;
    [titleView sizeToFit];
}

#pragma mark rest delegate
-(void)success:(NSMutableArray*)json{

    [self.privacidadOutlet setText:[json valueForKey:@"content"]];
    [self.tituloPrivacidadOutlet setText:[json valueForKey:@"title"]];
    
}

-(void)error:(NSString*)error{
    NSLog(@"Error: %@ ",error);
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}
@end
