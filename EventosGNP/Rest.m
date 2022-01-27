//
//  Rest.m
//  Servicios
//
//  Created by sensey on 03/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import "Rest.h"

@implementation Rest

-(void)restPostUrl:(NSString*)url withDic:(NSDictionary*)dic inView:(UIView *)vista{
    
    [self getViewLoading:vista isVisible:YES];
    
    [GMDCircleLoader setOnView:fondo withTitle:@"Espera un momento..." animated:YES];
    
    data = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getViewLoading:vista isVisible:NO];
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self getViewLoading:vista isVisible:NO];
        [self.delegate error:[error description]];
        
    }];
    
}



-(NSDictionary*)loginUser:(NSString*)user password:(NSString*)pass{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:user forKey:@"user"];
    [post setValue:pass forKey:@"password"];
    
    return post;
}

/* Funcion para recuperar password */
-(NSDictionary*)recoverPass:(NSString*)email{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:email forKey:@"email"];
    
    return post;
}

/* Funcion para recuperar password */
-(NSDictionary*)getPrivacidad{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:@"content" forKey:@"content"];
    [post setValue:@"title" forKey:@"title"];
    
    return post;
}

-(NSDictionary*)getTours{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:@"content" forKey:@"content"];
    [post setValue:@"title" forKey:@"title"];
    
    return post;
}

-(NSDictionary*)getRevista{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:@"content" forKey:@"content"];
    [post setValue:@"title" forKey:@"title"];
    
    return post;
}

-(NSDictionary*)getEvento{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:@"content" forKey:@"content"];
    [post setValue:@"title" forKey:@"title"];
    
    return post;
}

-(NSDictionary*)getDatos{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:@"content" forKey:@"content"];
    [post setValue:@"title" forKey:@"title"];
    
    return post;
}



-(NSDictionary*)getAyuda:(NSString*)principal{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:principal forKey:@"main"];
    
    return post;

}

-(void)getViewLoading:(UIView*)vista isVisible:(BOOL)visible{
    
    if(visible){
        fondo = [[UIView alloc] initWithFrame:vista.frame];
        
        //COLOR EN RGB
        [fondo setBackgroundColor:[UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.50]];
        
        [vista addSubview:fondo];
        
    }else{
        
        [fondo removeFromSuperview];
        
    }
}

-(NSDictionary*)name:(NSString*)name lastname_p:(NSString*)lastname_p lastname_m:(NSString*)lastname_m nickname:(NSString*)nickname gender:(NSString*)gender birthdate:(NSString*)birthdate email:(NSString*)email passport:(NSString*)passport visa:(NSString*)visa diet:(NSString*)diet allergies:(NSString*)allergies special_conditions:(NSString*)special_conditions smoker:(NSString*)smoker aidi:(NSString *)aidi{
    
    NSMutableDictionary* post = [NSMutableDictionary new];
    
    [post setValue:name forKey:@"name"];
    [post setValue:lastname_p forKey:@"lastname_p"];
    [post setValue:lastname_m forKey:@"lastname_m"];
    [post setValue:nickname forKey:@"nickname"];
    [post setValue:gender forKey:@"gender"];
    [post setValue:birthdate forKey:@"birthdate"];
    [post setValue:email forKey:@"email"];
    [post setValue:passport forKey:@"passport"];
    [post setValue:visa forKey:@"visa"];
    [post setValue:diet forKey:@"diet"];
    [post setValue:allergies forKey:@"allergies"];
    [post setValue:special_conditions forKey:@"special_conditions"];
    [post setValue:smoker forKey:@"smoker"];
    [post setValue:aidi forKey:@"id"];
    
    return post;
    
}

-(void)getEventos:(UIView*)vistas{
    
    if(![self VerifityConnection]){
        [self AlertShow:@"No tienes conexión" withTittle:@"Sin conexión"];
    }else{
    
        [self getViewLoading:vistas isVisible:YES];
        [GMDCircleLoader setOnView:fondo withTitle:@"Cargando Eventos..." animated:YES];
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://eventos.appsgnp.mx/api/eventos" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            [self getViewLoading:vistas isVisible:NO];
            data = (NSMutableArray*) responseObject;
            [self.delegate success:data];
        
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
            [self getViewLoading:vistas isVisible:NO];
            [self.delegate error:[error description]];
        }];
    }
}

-(void)AlertShow:(NSString*)message withTittle:(NSString*)tittle{

   UIAlertView* alerta = [[UIAlertView alloc]initWithTitle:tittle message:message delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
    
    [alerta performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

-(void)getAgendaActividad:(NSString*)idUsuario idActividad:(NSString*)idActividad inView:(UIView *)vista{
    
    [self getViewLoading:vista isVisible:YES];
    
    [GMDCircleLoader setOnView:fondo withTitle:@"Cargando Eventos..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://eventos.appsgnp.mx/api/actividad/agendar/%@/%@",idUsuario,idActividad] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getViewLoading:vista isVisible:NO];
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self getViewLoading:vista isVisible:NO];
        [self.delegate error:[error description]];
    }];
    
}

-(void)getActividadesPrograma:(NSString*)idUsuario idActividad:(NSString*)idActividad inView:(UIView*)vista{
    
    [self getViewLoading:vista isVisible:YES];
    
    [GMDCircleLoader setOnView:fondo withTitle:@"Cargando..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://eventos.appsgnp.mx/api/programa/actividades/%@/%@",idUsuario,idActividad] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",[NSString stringWithFormat:@"http://eventos.appsgnp.mx/api/programa/actividades/%@/%@",idUsuario,idActividad]);
        
        [self getViewLoading:vista isVisible:NO];
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self getViewLoading:vista isVisible:NO];
        [self.delegate error:[error description]];
    }];

}



-(void)getActividadesAgendadasPorUsuario:(NSString*)idUsuario inView:(UIView*)vista{
    
    
    [self getViewLoading:vista isVisible:YES];
    
    [GMDCircleLoader setOnView:fondo withTitle:@"Cargando..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://eventos.appsgnp.mx/api/agenda/%@",idUsuario] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getViewLoading:vista isVisible:NO];
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self getViewLoading:vista isVisible:NO];
        [self.delegate error:[error description]];
    }];
    
    
    
}


-(void)getProgramas:(UIView*)vistas{
    
    [self getViewLoading:vistas isVisible:YES];
    [GMDCircleLoader setOnView:fondo withTitle:@"Cargando Programa..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://eventos.appsgnp.mx/api/programa/2" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getViewLoading:vistas isVisible:NO];
        data = (NSMutableArray*) responseObject;
        
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self getViewLoading:vistas isVisible:NO];
        [self.delegate error:[error description]];
    }];
    
    
    
}

-(void)getNotificaciones:(NSString*)idUsuario inView:(UIView*)vista{
    
    [self getViewLoading:vista isVisible:YES];
    
    [GMDCircleLoader setOnView:fondo withTitle:@"Cargando..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://eventos.appsgnp.mx/api/notificaciones/%@",idUsuario] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getViewLoading:vista isVisible:NO];
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self getViewLoading:vista isVisible:NO];
        [self.delegate error:[error description]];
    }];
}

-(void)deleteNotificacion:(NSString *)idUsuario idNotificacion:(NSString*)idNotificacion inView:(UIView *)vista{
    
    [self getViewLoading:vista isVisible:YES];
    
    [GMDCircleLoader setOnView:fondo withTitle:@"Eliminando..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://eventos.appsgnp.mx/api/notificaciones/eliminar/%@/%@",idUsuario,idNotificacion] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getViewLoading:vista isVisible:NO];
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self getViewLoading:vista isVisible:NO];
        [self.delegate error:[error description]];
        
    }];
}

-(void)notificacionLeida:(NSString *)idUsuario idNotificacion:(NSString*)idNotificacion{
    
    
    //[GMDCircleLoader setOnView:fondo withTitle:@"Eliminando..." animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://eventos.appsgnp.mx/api/notificaciones/marcar/%@/%@",idUsuario,idNotificacion] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.delegate error:[error description]];
        
    }];
}




-(void)resPostWithImage:(NSString*)url withDic:(NSDictionary*)dic inView:(UIView*)vista image:(UIImage*)imagen {
    
    [self getViewLoading:vista isVisible:YES];
    [GMDCircleLoader setOnView:fondo withTitle:@"Guardando Perfil" animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSData *imageData = UIImageJPEGRepresentation(imagen, 0.5);
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //[self getViewLoading:vista isVisible:NO];
        
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"x.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self getViewLoading:vista isVisible:NO];
        
        data = (NSMutableArray*) responseObject;
        [self.delegate success:data];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //[self getViewLoading:vista isVisible:NO];
        [self.delegate error:[error description]];
        
    }];
}

-(BOOL)VerifityConnection{
    conectado = [[VerifyConnectionNetwork alloc] init];
    
    if (![conectado ConnectionNetwork:@"74.125.224.72"]) {
        return NO;
    }else
        return YES;
}

@end
