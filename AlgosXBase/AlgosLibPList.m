//
//  AlgosLibPList.m
//  AlgosXBase
//
//  Created by Marco Velluto on 04/10/12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "AlgosLibPList.h"

@implementation AlgosLibPList

//--Restituisce un booleano dal dizionario
+ (BOOL)boolValueFromDict:(NSDictionary *)dict forKey:(NSString *)key {
    BOOL booleano;
    NSNumber *num;
    NSNumber *zero = [[NSNumber alloc] initWithBool:false];
    
    if (dict) {
        num = [dict valueForKey:key];
        if ([num isEqualToNumber:zero]) {
            booleano = false;
        } else {
            booleano = true;
        }
    }
    return booleano;
}


//--- lista articoli in ordine alfabetico
//--- legge dictionary
//--- crea lista articoli
+ (NSArray *)arrayFromPlistName:(NSString *)plistName {
    
    NSDictionary *dictionary = [AlgosLibPList dictionaryWithString:plistName];
    NSArray *listaOggetti = [AlgosLibPList arrayFromDictionary:dictionary];
    listaOggetti = [listaOggetti sortedArrayUsingSelector:@selector(compare:)];
    
    return listaOggetti;
}

//--Recupera dalla pList un array di dati al primo livello
//--La pList NON deve essere un dizionario (al primo livello)
+ (NSArray *)arrayFromPlistWithName:(NSString *)plistName {
    NSArray *arrayList;
    NSString *plistPath;
    
    plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
       // NSString *path = [];
        NSDictionary *obj = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    }
    
    return arrayList;
}


//--- lista chiavi di primo livello in ordine alfabetico
//--- legge dictionary
//--- crea lista chiavi
+ (NSArray *)keysFromPlistName:(NSString *)plistName {
    NSArray *listaKeys;
    NSDictionary *dict;
    
    dict = [AlgosLibPList dictionaryWithString:plistName];
    if (dict) {
        listaKeys = [dict allKeys];
    }
    if (listaKeys) {
        listaKeys = [listaKeys sortedArrayUsingSelector:@selector(compare:)];
    }
    
    return listaKeys;
}

+ (BOOL)isEsistePlistForName:(NSString *)plistName {
    BOOL booleano = false;
    NSString *plistPath;
    
    plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        booleano = true;
    }
    return booleano;
}


+ (NSArray *)arrayFromDictionary:(NSDictionary *)dictionary {
    NSMutableArray *listaTemp = [[NSMutableArray alloc] init];
    for (id key in dictionary) {
        
        id value = [dictionary objectForKey:key];
        
        for (id riga in value) {
            
            id stringa = (NSString *)riga;
            //NSLog(@"Stringa = '%@'", stringa);
            [listaTemp addObject:stringa];
        }
    }
    return [[NSArray alloc] initWithArray:listaTemp];
}

+ (NSDictionary *)dictionaryWithString:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return dictionary;
}


+ (NSDictionary *)getDictionaryArticoliFromPlistName:(NSString *)plistName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return dictionary;
}


+ (void)writeDictionary:(NSDictionary *)dictionary fromPlistName:(NSString *)plistName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Pesi.plist"]; //3
    
    //here add elements to data file and write data to file
    [dictionary writeToFile: path atomically:YES];
}


+ (NSString *)pathPlist {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Pesi.plist"]; //3
    
    return path;
}


//LEGGE I DATI DALLA PLIST DATO IL NOME
+ (NSDictionary *)readPlistName:(NSString *)plistName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Pesi.plist"]; //3
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    //load from savedStock example int value
    
    return savedStock;
}

#pragma  mark - Metodi di comodo
+ (NSDictionary *)createDictionaryWithObject:(NSObject *)obj andKey:(NSString *)key {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:obj, key, nil];
    return dic;
}

@end
