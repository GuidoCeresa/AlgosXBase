//
//  ATableOpzioniController.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 2-12-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "ATableOpzioniController.h"
#import "ATableDetailController.h"
#import "AlgosBorderLabel.h"
#import "Const.h"
#import "AlgosLibView.h"
#import "DescVal.h"
#import "AFormInfoController.h"

@interface ATableOpzioniController ()

@end

//--Costruisce una tavola con n opzioni ognuna dei quali rimanda ad una serie di parametri
//--Tavola che utilizza i metodi e le regolazioni di default della superclasse
//--I parametri vengono presentati in una sotto-Tavola
//--Aggiunge il titolo (obbligatorio)
//--Aggiunge un header (opzionale)
@implementation ATableOpzioniController


#pragma mark - Synthesize Variables
//--nomi delle opzioni = chiavi ordinate del dizionario parametri
@synthesize opzioni;

//--testo selezionato di ogni opzione
@synthesize testoOpzioni;

//--valore selezionato di ogni opzione
@synthesize valoreOpzioni;

//--valori di tutti i parametri e delle opzioni per ciascuno
@synthesize parametri;


#pragma mark - Constants
//--Nome del campo chiave interno al NSDictionary
static NSString *kValori = @"valori";
static NSString *kValori2 = @"valoriOpzioniProtocollo";

//--Identificatore del segue tra opzioni e la tavola specializzata, nello storyboard
static NSString *kSegueDetail = @"segueDetail";

//--Identificatore del segue tra opzioni e la web view specializzata, nello storyboard
static NSString *kSegueInfo = @"segueFormInfo";

//--Nome del campo chiave interno al NSDictionary
static NSString *kDettaglio = @"dettaglioParametro";

//--Nome del campo chiave interno al NSDictionary
static NSString *kNomeOpzione = @"nomeOpzione";

//--Nome del campo chiave interno al NSDictionary
static NSString *kNomeParametro = @"nomeParametro";

//--Nome del campo chiave interno al NSDictionary
static NSString *kValoreParametro = @"valoreParametro";

//--Nome del campo chiave interno al NSDictionary
static NSString *kValoriParametriOpzione = @"valoriParametriOpzione";

//--Valore iniziale del testo dei parametri
static NSString *kValoreVuotoIniziale = @"... ...";

//--Altezza sezione footer
static int kAltezzaFooter = 50;

//--Colore del footer


#pragma mark - Local Variables
//--costanti della classe
NSString *kCellIdentifier2 = @"opzioniCell";
int extraPrimaSezione = 10;
int altezzaNormaleSezione = 30;


static int kTopInset = 0;
static int kAltLabelNomeOpzione = 25;
static int kAltSpazioLabel = 0;
static int kAltLabelValoreParametro = 25;
static int kBottomInset = 5;
int altezzaCella;

#pragma mark - Init View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //--regola l'altezza della cella
    altezzaCella = kTopInset + kAltLabelNomeOpzione + kAltSpazioLabel + kAltLabelValoreParametro + kBottomInset;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - Table view group section
//--Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [opzioni count];
}

#pragma mark - Table view data source
//--chiamata dal sistema ogni volta che deve disegnare una riga
//--la PrototypeCell dello storyboard è vuota
//--la label viene creata qui nel codice
//--la chiave per recuperare la cella dallo storyboard DEVE essere "opzioni"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSString *identifier = kCellIdentifier2;
    UIView *cellView;
    NSInteger riga = indexPath.row;

    //--se è già stata usata, recupera la cella
    cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //--Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
        
    //--crea la view
    cellView = [self elaboraCellaWithRiga:riga];
    
    //--attacca la view alla cella
    if ([cell.contentView subviews]) {
        for (UIView *subView in [cell.contentView subviews]) {
            [subView removeFromSuperview];
        }
    }
    [cell.contentView addSubview:cellView];
        
    //--restituisce al sistema la cella configurata
    return cell;
}

//--Elabora la view interna della cella
//--Recupera i valori della descrizione della opzione e del valore corrente del parametro eventualmente selezionato
//--Disegna la view
- (UIView *)elaboraCellaWithRiga:(int)riga {
    UIView *cellView;
    NSString *opzione;
    NSString *valoreParametro;

    opzione = [opzioni objectAtIndex:riga];
    valoreParametro = [testoOpzioni objectAtIndex:riga];
    cellView = [self disegnaCellaForOpzione:opzione opzione:valoreParametro];
    return cellView;
}

//--Disegna la view interna della cella
//--Sfondo trasparente
//--Descrizione in grassetto della opzione
//--Campo edit col valore selezionato del parametro corrente
- (UIView *)disegnaCellaForOpzione:(NSString *)opzione opzione:(NSString *)valoreParametro {
    UIView *cellView = [[UIView alloc] init];
    AlgosBorderLabel *labelOpzione;
    AlgosBorderLabel *labelParametro;

    labelOpzione = [self creaLabelOpzione:opzione];
    labelParametro = [self creaLabelParametro:valoreParametro];
    [cellView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [cellView addSubview:labelOpzione];
    [cellView addSubview:labelParametro];
    
    return cellView;
}

//--Crea la label per la descrizione della opzione
- (AlgosBorderLabel *)creaLabelOpzione:(NSString *)testo {
    AlgosBorderLabel *label;
    CGRect labelFrame = CGRectMake(10, kTopInset, 280, kAltLabelNomeOpzione);
    
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    [label setBackgroundColor:[UIColor clearColor]];
    //[label setBackgroundColor:[UIColor greenColor]];
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont boldSystemFontOfSize:17.0]];
    [label setText:testo];
    
    return label;
}

//--Crea la label per il valore del parametro
- (AlgosBorderLabel *)creaLabelParametro:(NSString *)testo {
    AlgosBorderLabel *label;
    CGRect labelFrame = CGRectMake(10, kTopInset + kAltLabelNomeOpzione + kAltSpazioLabel, 280, kAltLabelValoreParametro);
    
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    [label setBackgroundColor:[UIColor clearColor]];
    //[label setBackgroundColor:[UIColor redColor]];
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont italicSystemFontOfSize:15.0]];
    [label setText:testo];
    
    return label;
}

//--chiamata dal sistema ogni volta che deve disegnare una riga
//--utilizza (tramite delega) lo stesso metodo usato per dimensionare la label della cella
//--calcola l'altezza esatta della label che contiene il testo
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return altezzaCella;
}



#pragma mark - Table view sections footer
// custom view for footer. will be adjusted to default or specified footer height
// Notice: this will work only for one section within the table view
//--Elabora il footer
//--All'apertura della finestra deve essere vuoto
//--Le opzioni devono avere TUTTE un valore; altrimenti mostra un messaggio di avviso (dopo aver selezionato almeno un parametro)
//--Se ci sono tutti i valori delle opzioni, calcola la somma ed elabora la risposta ed il colore del messaggio
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *localFooterView;
    NSArray *array = testoOpzioni;
    
    if ([self isArrayIniziale:array]) {
        localFooterView = [self footerViewIniziale];
    } else {
        if ([self isArrayCompleto:array]) {
            localFooterView = [self footerViewCompletaForFile:nomeFilePList];
        } else {
            localFooterView = [self footerViewParziale];
        }
    }
        
    //return the view for the footer
    return localFooterView;
}

- (UIView *)footerViewWithTesto:(NSString *)testo colore:(UIColor *)colore font:(UIFont *)font dettaglio:(NSString *)dettaglio {
    UIView *localFooterView;
    CGRect labelFrame;
    CGRect labelFrameDettaglio;
    AlgosBorderLabel* label;
    AlgosBorderLabel* labelDettaglio;
    int topInset = 10;
    int lar = 270;
    UIFont *fontDettaglio = [font fontWithSize:15];
    
    localFooterView  = [[UIView alloc] init];
    labelFrame = CGRectMake((320 - lar)/2, topInset, lar, kAltezzaFooter - topInset);
    label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
    label.numberOfLines = 1;
    [label setFont:font];
    label.textAlignment = NSTextAlignmentCenter;
    [label setText:testo];
    if (colore) {
        [label setBackgroundColor:colore];
    } else {
        [label setBackgroundColor:[Const instance].grigioCeleste];
    }
    [localFooterView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [localFooterView addSubview:label];
    if (dettaglio) {
        labelFrameDettaglio = CGRectMake((320 - lar)/2, 40, lar, 30);
        labelDettaglio = [[AlgosBorderLabel alloc] initWithFrame:labelFrameDettaglio];
        labelDettaglio.numberOfLines = 1;
        [labelDettaglio setFont:fontDettaglio];
        labelDettaglio.textAlignment = NSTextAlignmentCenter;
        [labelDettaglio setText:dettaglio];
        if (colore) {
            [labelDettaglio setBackgroundColor:colore];
        } else {
            [labelDettaglio setBackgroundColor:[Const instance].grigioCeleste];
        }
        [localFooterView addSubview:labelDettaglio];
    }
    
    return localFooterView;
}

- (UIView *)footerViewIniziale {
    UIView *localFooterView;
    NSString *testo = @"";
    UIColor *colore = nil;
    UIFont *font = [UIFont systemFontOfSize:15];
    
    localFooterView = [self footerViewWithTesto:testo colore:colore font:font dettaglio:nil];
    
    return localFooterView;
}

- (UIView *)footerViewParziale {
    UIView *localFooterView;
    NSString *testo = @"Completa i valori di tutte le opzioni";
    UIColor *colore = nil;
    UIFont *font = [UIFont italicSystemFontOfSize:13];
    
    localFooterView = [self footerViewWithTesto:testo colore:colore font:font dettaglio:nil];
    
    return localFooterView;
}

- (UIView *)footerViewCompletaForFile:nomeFilePList {
    return nil;
}

//--Regola l'altezza della sezione footer. Se non usa il footer, viene messa a zero
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kAltezzaFooter;
}

#pragma mark - Table Edit
//--selezionata una riga della tabella--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        //    [self.navigationController performSegueWithIdentifier:kSegueDetail sender:nil];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}

#pragma mark - View Edit
//--Bottone info nella barra di navigazione--
- (IBAction)openInfoScheda:(id)sender {
    NSString *identifier = kSegueInfo;
    
    @try {
        [self performSegueWithIdentifier:identifier sender:self];
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}


#pragma mark - Table view delegate
//--dopo aver selezionato il segue, passa di qui per eventuali regolazioni--
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger riga = indexPath.row;
    NSString *nomeOpzione;
    NSMutableArray *arrayOpzioniTmp = [[NSMutableArray alloc] init];
    DescVal *descVal;
    NSDictionary *dicSingolaOpzione;
    NSString *valoreSelezionato;
    NSArray *arrayDizionariParametri;
    
    if ([[segue identifier] isEqualToString:kSegueDetail]) {
        nomeOpzione = [opzioni objectAtIndex:riga];
        valoreSelezionato = [testoOpzioni objectAtIndex:riga];
        dicSingolaOpzione = [parametri objectForKey:nomeOpzione];
        
        if (dicSingolaOpzione) {
            if ([dicSingolaOpzione objectForKey:kValoriParametriOpzione]) {
                arrayDizionariParametri = [dicSingolaOpzione objectForKey:kValoriParametriOpzione];
            }
        }
        
        if (arrayDizionariParametri) {
            for (NSDictionary *dictParametri in arrayDizionariParametri) {
                descVal = [[DescVal alloc] init];
                if ([dictParametri objectForKey:kNomeParametro]) {
                    descVal.descrizione = [dictParametri objectForKey:kNomeParametro];
                }
                if ([dictParametri objectForKey:kDettaglio]) {
                    descVal.detail = [dictParametri objectForKey:kDettaglio];
                }
                if ([dictParametri objectForKey:kValoreParametro]) {
                    descVal.valore = [dictParametri objectForKey:kValoreParametro];
                }
                [arrayOpzioniTmp addObject:descVal];
            }
        }

        ATableDetailController *destViewController = segue.destinationViewController;
        destViewController.titoloFinestra = nomeOpzione;
       // destViewController.opzioni= arrayOpzioniTmp;
        destViewController.opzioni= arrayDizionariParametri;
        destViewController.valoreSelezionato = valoreSelezionato;
        destViewController.delegate = self;
    }

    if ([[segue identifier] isEqualToString:kSegueInfo]) {
        AFormInfoController *destViewController = segue.destinationViewController;
        destViewController.nomeInfoFile = nomeFilePList;
    }
}

//--Ritorno da ATableDetail col valore selezionato
//--Regola il testo della opzione
- (void)detailViewTerminated:(NSString *)valoreSelezionato {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger riga = indexPath.row;
    [testoOpzioni replaceObjectAtIndex:riga withObject:valoreSelezionato];
  //  [valoreOpzioni replaceObjectAtIndex:riga withObject:2];
    //[self elaboraFooter];
}

#pragma mark - Utility methods
//--Recupera la somma dei valori di ogni opzione
- (int)getValoreOpzioni {
    int somma = 0;

    if (opzioni) {
        for (int k=0; k < [opzioni count]; k++) {
            somma += [self getValoreForOpzione:k];
        }
    }
    return somma;
}

//--Recupera il valore di un parametro
- (int)getValoreForOpzione:(int)posOpzione {
    int valore = 0;
    NSString *valoreOpzione;
    NSDictionary *dictOpzione;
    NSDictionary *dictParametri;
    NSArray *arrayParametri;
    NSString *nomeParametro;
    
    valoreOpzione = [testoOpzioni objectAtIndex:posOpzione];
    if ([parametri objectForKey:[opzioni objectAtIndex:posOpzione]]) {
        dictOpzione = [parametri objectForKey:[opzioni objectAtIndex:posOpzione]];
        if ([dictOpzione objectForKey:kValoriParametriOpzione]) {
            arrayParametri = [dictOpzione objectForKey:kValoriParametriOpzione];
            for (dictParametri in arrayParametri) {
                if ([dictParametri objectForKey:kNomeParametro]) {
                    nomeParametro = [dictParametri objectForKey:kNomeParametro];
                    if ([nomeParametro isEqualToString:valoreOpzione]) {
                        valore = [[dictParametri objectForKey:kValoreParametro] intValue];
                    }
                }
            }
        }
    }
    return valore;
}


//--reset di alcuni parametri--
//--Utilizzato solo dalle sottoclassi
- (void)resetInizialeParametri {
    parametri = nil;
    opzioni = nil;
    testoOpzioni = nil;
    valoreOpzioni = nil;
}

#pragma mark - Utility methods
//--Elabora il testo da mostrare nel footer--
- (void)elaboraFooter {
    NSString *testo;
    
    if (true) {
        testo = @"pippoz";
    } else {
        testo = @"pippoz";
    }
    
    super.testoFooter = testo;
   // super.usaFooter = true;
   // super.usaViewFooter = true;
}


//--Recupera le chiavi del dizionario che sono le opzioni da mostrare
//--Utilizzato solo dalla sottoclasse ATableOpzioni
//--Presuppone che lo schema della pList sia costituito da:
//--n dizionari (opzioni), ognuno contenente n dizionari (parametri)
//--L'ordine non è garantito
- (void)setUpOpzioni {
    NSMutableArray *arrayOpzioniTmp = [[NSMutableArray alloc] init];
    NSDictionary *dictRoot = [super getDictionary];
    NSObject *obj;
    NSArray *arrayRoot;
    NSString *kNome = @"nomeOpzione";
    NSString *nomeOpzione;
    
    if (dictRoot) {
        obj = [dictRoot objectForKey:kValori2];
        if ([obj isKindOfClass:[NSArray class]]) {
            arrayRoot = (NSArray *)obj;
            for (NSDictionary *dict in arrayRoot) {
                if ([dict objectForKey:kNome]) {
                    nomeOpzione = [dict objectForKey:kNome];
                    [arrayOpzioniTmp addObject:nomeOpzione];
                }
            }
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
        }
        opzioni = arrayOpzioniTmp;
    }
}


//--Recupera le chiavi del dizionario che sono le sezioni da mostrare
//--Utilizzato solo dalla sottoclasse ATableOpzioni
//--Presuppone che lo schema della pList sia costituito da:
//--n dizionari (opzioni), ognuno contenente n dizionari (parametri)
//--L'ordine non è garantito
- (void)setUpTestoOpzioni {
    testoOpzioni = [[NSMutableArray alloc] init];
    valoreOpzioni = [[NSMutableArray alloc] init];
    
    if (opzioni) {
        for (NSString *key in opzioni) {
            [testoOpzioni addObject:kValoreVuotoIniziale];
            [valoreOpzioni addObject:[NSNumber numberWithInt:0]];
        }
    }
}


//--recupera i valori di tutti i parametri
//--Utilizzato solo dalla sottoclasse ATableOpzioni
//--Presuppone che lo schema della pList sia costituito da:
//--n dizionari (opzioni), ognuno contenente n dizionari (parametri)
//--L'ordine non è garantito
- (void)setUpParametri {
    NSMutableDictionary *dictParametriTmp = [[NSMutableDictionary alloc] init];
    NSDictionary *dictRoot = [super getDictionary];
    NSObject *obj;
    NSArray *arrayRoot;
    NSString *chiave;
    
    if (dictRoot) {
        obj = [dictRoot objectForKey:kValori2];
        if ([obj isKindOfClass:[NSArray class]]) {
            arrayRoot = (NSArray *)obj;
            for (NSDictionary *dict in arrayRoot) {
                if ([dict objectForKey:kNomeOpzione]) {
                    chiave = [dict objectForKey:kNomeOpzione];
                    [dictParametriTmp setObject:dict forKey:chiave];
                }
            }
        }
    }
    parametri = dictParametriTmp;
}

//--Controlla che l'array sia vuoto (valori iniziali)
//--Tutti i valori uguali al valore iniziale (kValoreVuoto)
- (BOOL)isArrayIniziale:(NSArray *)array {
    BOOL iniziale = false;
    BOOL diverso = false;

    if (array) {
        for (NSString *chiave in array) {
            if (![chiave isEqualToString:kValoreVuotoIniziale]) {
                diverso = true;
            }
        }
        //--se anche uno solo ha il valore iniziale, l'array non è completo di valori validi
        iniziale = ! diverso;
    }
    return iniziale;
}


//--Controlla che l'array sia pieno (valori validi e non nulli)
//--Tutti i valori diversi dal valore iniziale (kValoreVuoto)
- (BOOL)isArrayCompleto:(NSArray *)array {
    BOOL completo = false;
    BOOL iniziale = false;
    
    if (array) {
        for (NSString *chiave in array) {
            if ([chiave isEqualToString:kValoreVuotoIniziale]) {
                iniziale = true;
            }
        }
        //--se anche uno solo ha il valore iniziale, l'array non è completo di valori validi
        completo = ! iniziale;
    }
    return completo;
}

@end



