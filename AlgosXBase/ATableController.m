//
//  AlgosTableController.m
//  AlgosXBase
//
//  Created by Guido Ceresa on 29-11-12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import "ATableController.h"
#import "AlgosLibView.h"
#import "AlgosLibPList.h"
#import "AlgosBorderLabel.h"

@implementation ATableController

#pragma mark - Synthesize Variables
@synthesize headerView;
@synthesize footerView;
@synthesize myData;
@synthesize usaHeader;
@synthesize usaFooter;
@synthesize usaTextFooter;
@synthesize usaViewFooter;
@synthesize usaGrigiAlternati;
@synthesize titolo;

#pragma mark - Synthesize Variables
@synthesize titoloFinestra;
@synthesize nomeFilePList;

#pragma mark - Constants
//--Nome del campo chiave interno al NSDictionary
static NSString *kValori = @"valori";

//--Nome del campo chiave interno al NSDictionary
static NSString *kDescrizione = @"descrizione";

//--costanti della classe
static NSString *kTitoloMancante = @"manca";

//--Valori di default
static int righeHeaderDefault = 1;
static int dimCarattereNormaleDefault = 17;
static int dimCarattereHeaderDefault = 15;
static int numCaratteriPerRigaDefault = 40;
static int numCaratteriHeaderPerRigaDefault = 45;
static int topPosizioneValori = 50; //default - modificata dall'altezza della descrizione
static int altezzaRigaNormaleDefault2 = 24;
static int altezzaRigaHeaderDefault = 22;

#pragma mark - Local Variables
//--testi di descrizione
NSString *testoFooter;
BOOL isFooter;

//--dimensionamento dell'header e dello spazio occupato
int righeHeader;
int dimCarattereNormale;
int dimCarattereHeader;
int altezzaRigaNormale;
int altezzaRigaHeader;
int numCaratteriPerRiga;
int numCaratteriHeaderPerRiga;

//--colori di sfondo delle label
UIColor *coloreHeader;
UIColor *coloreFooter;
UIColor *coloreBodyChiaro;
UIColor *coloreBodyScuro;

#pragma mark - Init
//--Inizializza le variabili
//--Di default NON usa header e NON usa footer
//--Di default USA l'alternanza delle righe di due grigi diversi
- (void)initVariables {
    usaHeader = false;
    usaFooter = false;
    usaGrigiAlternati = true;
}

#pragma mark - Init View
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //--regolazioni varie iniziali--
    [self regolazioniIniziali];
}

//--regolazioni varie iniziali--
- (void)regolazioniIniziali {
    
    //--reset di alcuni parametri--
    [self resetInizialeParametri];
    
    //--titolo della finestra--
    if (titoloFinestra) {
        [self setTitle:titoloFinestra];
    } else {
        [self setTitle:kTitoloMancante];
    }

    //--descrizione della scheda--
    //--header--
    [self setUpDescrizione];
    
    //--valori delle righe--
    [self setUpValori];

    //--recupera le chiavi del dizionario che sono le sezioni da mostrare
    //--Utilizzato solo dalla sottoclasse ATableOpzioni
    [self setUpSezioni];

    //--recupera i valori di tutti i parametri
    //--Utilizzato solo dalla sottoclasse ATableOpzioni
    [self setUpParametri];

    //--utilizzo dei numeri
    //--numero iniziale: zero o uno di solito
    //--Utilizzato solo dalla sottoclasse ATableLabel
    [self setUpNumeri];
}

#pragma mark - Table view group section
//--Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//--Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    	  return [myData objectAtIndex:section];
}

// Custom view for header. Will be adjusted to default or specified header height
// Notice: this will work only for one section within the table view
//--le righe vengono calcolate in base alla lunghezza del testo
//--ed a un numero fisso di caratteri per riga (sperimentale)
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *localHeaderView;
    
    if (usaHeader) {
        if (testoHeader) {
            //--crea la view (che contiene la label) con le esatte dimensioni per il testo
            localHeaderView = [AlgosLibView creaViewWithTesto:testoHeader];
        }
    }
    return localHeaderView;
}



//--Regola l'altezza della sezione header. Se non usa l'header, viene messa a zero
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (usaHeader) {
        if (testoHeader) {
            //--calcola l'altezza esatta della label che contiene il testo
            return [AlgosLibView altezzaLabelWithTesto:testoHeader];
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}


// custom view for footer. will be adjusted to default or specified footer height
// Notice: this will work only for one section within the table view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *localFooterView;
    CGRect labelFrame;
    AlgosBorderLabel* label;
    
    if(usaFooter) {
        //allocate the view if it is needed
        localFooterView  = [[UIView alloc] init];
        
        if (usaTextFooter && !usaViewFooter) {
            labelFrame = CGRectMake(0, 0, 320, 24);
            label = [[AlgosBorderLabel alloc] initWithFrame:labelFrame];
            localFooterView.backgroundColor = coloreFooter;
            label.leftInset = 5;
            label.rightInset = 5;
            [label setBackgroundColor:coloreFooter];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 1;
            [label setFont:[UIFont systemFontOfSize:dimCarattereNormale]];
            [label setText:NSLocalizedString(testoFooter,@"Instructions Personal Profile")];
            [localFooterView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [localFooterView addSubview:label];
            
        } else {
            
            //we would like to show a gloosy red button, so get the image first
            UIImage *image = [[UIImage imageNamed:@"button_red.png"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
            
            //create the button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setBackgroundImage:image forState:UIControlStateNormal];
            
            //the button should be as big as a table view cell
            [button setFrame:CGRectMake(10, 3, 300, 44)];
            
            //set title, font size and font color
            [button setTitle:@"Remove" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            //set action of the button
            [button addTarget:self action:@selector(removeAction:)
             forControlEvents:UIControlEventTouchUpInside];
            
            //add the button to the view
            //[footerView addSubview:button];
            localFooterView.backgroundColor = [UIColor yellowColor];
        }
    }
    
    //return the view for the footer
    return localFooterView;
}


//--Regola l'altezza della sezione footer. Se non usa il footer, viene messa a zero
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //differ between your sections or if you
    //have only on section return a static value
    if (usaFooter) {
        return 24;
    } else {
        return 0;
    }
}


#pragma mark - Table view data source

#pragma mark - Table view delegate

#pragma mark - Setter and getter methods
- (void)setTestoHeader:(NSString *)testo {
    if (testo) {
        testoHeader = testo;
        usaHeader = true;
    } else {
        usaHeader = false;
    }
}

- (void)setTextFooterOnly:(NSString *)testo {
    if (testo) {
        testoFooter = testo;
        usaTextFooter = true;
    } else {
        usaTextFooter = false;
    }
    usaFooter = true;
    usaViewFooter = false;
}

- (void)setTexFooterAndView:(NSString *)testo; {
    if (testo) {
        testoFooter = testo;
        usaTextFooter = true;
    } else {
        usaTextFooter = false;
    }
    usaFooter = true;
    usaViewFooter = true;
}

#pragma mark - Utilitie methods
//--reset di alcuni parametri--
//--Utilizzato solo dalle sottoclassi
- (void)resetInizialeParametri {
}


//--recupera la descrizione della scheda dalla pList--
//--regola la variabile d'istanza--
- (void)setUpDescrizione {
    NSString *descrizione;
    NSDictionary *dict = [self getDictionary];
    
    if (dict) {
        descrizione = [dict objectForKey:kDescrizione];
    }
    [self setTestoHeader:descrizione];
}

//--recupera le chiavi del dizionario che sono le sezioni da mostrare
//--Utilizzato solo dalla sottoclasse ATableOpzioni
- (void)setUpSezioni {
}

//--utilizzo dei numeri
//--numero iniziale: zero o uno di solito
//--Utilizzato solo dalla sottoclasse ATableLabel 
- (void)setUpNumeri {
}

//--recupera i valori di tutti i parametri
//--Utilizzato solo dalla sottoclasse ATableOpzioni
- (void)setUpParametri {
}

//--recupera l'array dei valori dalla pList--
//--regola la variabile d'istanza della superclasse--
- (void)setUpValori {
    NSArray *listaValori;
    NSDictionary *dict = [self getDictionary];
    
    if (dict) {
        listaValori = [dict objectForKey:kValori];
    }
    myData = listaValori;
}


//--recupera il dictionary dalla pList--
- (NSDictionary *)getDictionary {
    NSDictionary *dict;
    NSString *nomeFile;
    
    if (nomeFilePList) {
        nomeFile = nomeFilePList;
        dict = [AlgosLibPList dictionaryWithString:nomeFile];
    }
    return dict;
}

@end
