//
//  InfoViewController.m
//  Card Box
//
//  Created by Koldo Ruiz on 22/05/13.
//
//

#import "InfoViewController.h"

@interface InfoViewController(Private)

@end

@implementation InfoViewController

@synthesize contentView;

@synthesize text1, text2 ,text3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    
    //Determina si el telefono esta en ingles o castellano y muestra un texto u otro segun el idioma
    NSArray* languages = [NSLocale preferredLanguages];
    NSString* preferredLang = [languages objectAtIndex:0];
    
    
    if([preferredLang isEqual:@"es"])
    {
         self.title=@"Instrucciones";
        text1.text=@"1 - Haz click en la imagen y añade una foto de la parte posterior de tu tarjeta.                      ";
        text2.text=@"2 - Haz click en la imagen y añade una foto del reverso de tu tarjeta.                              ";
        text3.text=@"3 - Escribe un nombre y pulsa (Guardar).                     ";
        
        
        
        
    }
    else{
        self.title=@"Instructions";
        text1.text=@"1 - Click on the picture to add the front side photo of your card.               ";
        text2.text=@"2 - Click on the picture to add the back side photo of your card.               ";
        text3.text=@"3 - Enter a name and press (Save)              ";
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}







@end
