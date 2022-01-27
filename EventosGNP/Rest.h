//
//  Rest.h
//  Servicios
//
//  Created by sensey on 03/03/15.
//  Copyright (c) 2015 Sensys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "GMDCircleLoader.h"
#import "VerifyConnectionNetwork.h"

@protocol restDelegate

    -(void)success:(NSMutableArray*)json;
    -(void)error:(NSString*)error;

@end

@interface Rest : NSObject{
    NSMutableArray* data;
    UIView* fondo;
    UILabel* texto;
    
    VerifyConnectionNetwork* conectado;
}

-(void)restPostUrl:(NSString*)url withDic:(NSDictionary*)dic inView:(UIView*)vista;
-(void)resPostWithImage:(NSString*)url withDic:(NSDictionary*)dic inView:(UIView*)vista image:(UIImage*)imagen;
-(void)getEventos:(UIView*)vistas;
-(void)getTours:(UIView*)vistas;
-(void)getProgramas:(UIView*)vistas;
-(void)getAgendaActividad:(NSString*)idUsuario idActividad:(NSString*)idActividad inView:(UIView*)vista;
-(void)getActividadesAgendadasPorUsuario:(NSString*)idUsuario inView:(UIView*)vista;
-(void)getActividadesPrograma:(NSString*)idUsuario idActividad:(NSString*)idActividad inView:(UIView*)vista;

-(void)getNotificaciones:(NSString*)idUsuario inView:(UIView*)vista;
-(void)deleteNotificacion:(NSString*)idUsuario idNotificacion:(NSString*)idNotificacion inView:(UIView*)vista;
-(void)notificacionLeida:(NSString*)idUsuario idNotificacion:(NSString*)idNotificacion;

-(NSDictionary*)loginUser:(NSString*)user password:(NSString*)pass;
-(NSDictionary*)recoverPass:(NSString*)email;
-(NSDictionary*)getPrivacidad;
-(NSDictionary*)getEvento;
-(NSDictionary*)getPrograma;
-(NSDictionary*)getRevista;
-(NSDictionary*)getDatos;
-(NSDictionary*)getTours;
-(NSDictionary*)getAyuda:(NSString*)principal;



-(NSDictionary*)name:(NSString*)name lastname_p:(NSString*)lastname_p lastname_m:(NSString*)lastname_m nickname:(NSString*)nickname gender:(NSString*)gender birthdate:(NSString*)birthdate email:(NSString*)email passport:(NSString*)passport visa:(NSString*)visa diet:(NSString*)diet allergies:(NSString*)allergies special_conditions:(NSString*)special_conditions smoker:(NSString*)smoker aidi:(NSString*)aidi;

@property(nonatomic,retain)id<restDelegate>delegate;

@end