//
//  AddRecipeViewController.m
//  Card Box
//
//  Created by Koldo Ruiz on 20/05/13.
//
//

#import "AddRecipeViewController.h"
#import "Recipes.h"
#import "InfoViewController.h"
#import "RootViewController.h"


@interface AddRecipeViewController(Private)

@end

int interruptorfoto=0;
int fotoSelected=0;
int caracruz;
int contador=0;

@implementation AddRecipeViewController

@synthesize recipes, textFieldOne, textFieldTwo, photoButton , tarjetas;


@synthesize contentView;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    self.navigationController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
    
    //detecta idioma y muestra el texto segun este o bien ingles o bien castellano
    NSArray* languages = [NSLocale preferredLanguages];
    NSString* preferredLang = [languages objectAtIndex:0];
    
    
    if([preferredLang isEqual:@"es"])
    {
        
        self.title = @"Añadir Tarjeta";
        textFieldOne.placeholder=@"Introduce el nombre de tu tarjeta.";
        
    }
    else{
        
        self.title=@"Add Card";
         textFieldOne.placeholder=@"Enter the name of your card.";
        
    }
    
    
    
    
	//creamos el boton cancelar
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
    caracruz=0;
    
    
    if (contador==0)
    {
        contador++;
        InfoViewController *infoView = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:infoView animated:YES];
    }
    
    
    if([preferredLang isEqual:@"es"])
    {
        
        	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Guardar" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
            self.navigationItem.rightBarButtonItem = saveButton;
            [saveButton release];
        
    }
    else{
        
       	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
        self.navigationItem.rightBarButtonItem = saveButton;
        [saveButton release];
        
    }
    

	//[photoButton setImage:recipes.recipeThumbnailImage forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	//[photoButton setImage:recipes.recipeThumbnailImage forState:UIControlStateNormal];
}
	

- (void)cancel {
	[recipes.managedObjectContext deleteObject:recipes];
	NSError *error = nil;
	if (![recipes.managedObjectContext save:&error]) {
		// Handle error
		//NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    [self dismissViewControllerAnimated:YES completion:nil];
       
    
}

//Guarda la tarjeta siempre y cuando hayamos introducido un nombre y sus respectivas fotos
- (void)save {
    if(textFieldOne.text.length!=0&&fotoSelected==1)
    {
        recipes.recipeName = textFieldOne.text;
        NSError *error = nil;
        if (![recipes.managedObjectContext save:&error])
        {
            // Handle error
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            exit(-1);  // Fail
        }
        fotoSelected=0;
        
        
        
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            if(result.height == 568)
            {
                [self dismissViewControllerAnimated:NO completion:nil];
            }
        }
        
    }
    else{
       
        NSArray* languages = [NSLocale preferredLanguages];
        NSString* preferredLang = [languages objectAtIndex:0];
        
        
        if([preferredLang isEqual:@"es"])
        {
            
                  UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                          message:@"Introduce nombre y fotos para la tarjeta."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
            [message show];
            
        }
        else{
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Notification"
                                                              message:@"Insert name and pictures to the card."
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }

        
      }
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Photo 


//Funcion que abre el image picker o bien de camara o de galeria para añadir fotos a nuestra tarjeta
- (IBAction)photoButtonPressed {
	[textFieldOne endEditing:YES];
	[textFieldTwo endEditing:YES];
    
    
    NSArray* languages = [NSLocale preferredLanguages];
    NSString* preferredLang = [languages objectAtIndex:0];
    
    
    if([preferredLang isEqual:@"es"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Aviso"
                                                       message: @"¿Deseas sacar una foto o utilizar una existente?"
                                                      delegate: self
                                             cancelButtonTitle:@"Camara"
                                             otherButtonTitles:@"Galeria",nil];
        [alert show];
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Notification"
                                                       message: @"¿Do you wish to take a picture or use an existing photo?"
                                                      delegate: self
                                             cancelButtonTitle:@"Camera"
                                             otherButtonTitles:@"Saved Photos",nil];
        [alert show];
    }
 
    interruptorfoto=1;
}




//provoca que el alert view que se muestra al pulsar el boton nos lleve o bien a la camara o bien a la galeria dependiendo de nuestra eleccion
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(interruptorfoto==1)
    {
        if (buttonIndex == 0)
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
                
                
                
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                {
                    CGSize result = [[UIScreen mainScreen] bounds].size;
                    if(result.height == 480)
                    {
                         [self presentViewController:imagePicker animated:YES completion:nil];
                    }
                    if(result.height == 568)
                    {
                        [self presentViewController:imagePicker animated:NO completion:nil];
                    }
                }
                
                [imagePicker release];
            }
        else
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
                
                
                
                
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                {
                    CGSize result = [[UIScreen mainScreen] bounds].size;
                    if(result.height == 480)
                    {
                        [self presentViewController:imagePicker animated:YES completion:nil];
                    }
                    if(result.height == 568)
                    {
                        [self presentViewController:imagePicker animated:NO completion:nil];
                    }
                }
                [imagePicker release];
            }
        interruptorfoto=0;
    }
    else
    {
        
    }
}





- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
	if(caracruz==0)
    {
       /* NSManagedObject *oldImage = recipes.recipeImage;
        if (oldImage != nil)
        {
            [recipes.managedObjectContext deleteObject:oldImage];
        } */
	
        RecipeImage *image = [NSEntityDescription insertNewObjectForEntityForName:@"RecipeImage" inManagedObjectContext:recipes.managedObjectContext];
        recipes.recipeImage = image;
        [image setValue:selectedImage forKey:@"recipeImage"];
        caracruz++;
        
        UIImage *secondImage = [UIImage imageNamed:@"tarjeta trasera.png"];
        [UIView transitionWithView:tarjetas duration:0.6
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               tarjetas.image = secondImage;
                           } completion:nil];
        
    }
    else{
        recipes.recipeThumbnailImage= selectedImage;
        UIImage *thirdImage = [UIImage imageNamed:@"tarjetaok.png"];
        [UIView transitionWithView:tarjetas duration:0.6
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               tarjetas.image = thirdImage;
                           } completion:nil];
        
        photoButton.enabled=NO;
        fotoSelected=1;
	}
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            [self dismissModalViewControllerAnimated:YES];
        }
        if(result.height == 568)
        {
            [self dismissModalViewControllerAnimated:NO];
        }
    }
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if(result.height == 568)
        {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }
    
    
    
}

- (void)dealloc {
	[recipes release];
	[textFieldOne release];
	[textFieldTwo release];
	[photoButton release];
    [super dealloc];
    
}


//esconde el teclado al pinchar fuera del UITextField
-(IBAction)hidekeyboard:(id)sender
{
    [self.view endEditing:YES];
}


//te lleva al panel de las intrucciones
-(IBAction)informacion:(id)sender
{
    InfoViewController *infoView = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:infoView animated:YES];
    
}


//esconde el teclado al 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}






- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}



@end
