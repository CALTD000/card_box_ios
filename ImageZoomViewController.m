//
//  ImageZoomViewController.m
//  Card Box
//
//  Created by Koldo Ruiz on 22/05/13.
//
//

#import "ImageZoomViewController.h"
#import "AddRecipeViewController.h"
#import "RootViewController.h"
#import "Recipes.h"
#import <QuartzCore/QuartzCore.h>



@interface ImageZoomViewController (UtilityMethods)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;


@end

int zoom;
int vuelta;
NSTimer *tiempoFoto;

@implementation ImageZoomViewController

@synthesize scrollView, demoImageView;
@synthesize singleTap, doubleTap, twoFingerTap;
@synthesize recipes;
@synthesize contentView;

#define ZOOM_STEP 1.5









#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
    //Inicializa dos variables tipo INT que mas tarde utilizaremos para controlar el zoom y las vueltas que da la tarjeta.
    zoom=0;
    vuelta=0;
    
    
    //Definimos el lenguaje que el usuario del iphone esta utilizando.
    NSArray* languages = [NSLocale preferredLanguages];
    NSString* preferredLang = [languages objectAtIndex:0];
    
    
    //Dependiendo de que lenguaje utilize en su teléfono colocamos los botones en ingles o en castellano.
    if([preferredLang isEqual:@"es"])
    {
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Voltear" style:UIBarButtonItemStyleBordered target:self action:@selector(handleTwoFingerTap:)];
        self.navigationItem.rightBarButtonItem = flipButton;
        [flipButton release];
    }
    else{
        
         UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Flip" style:UIBarButtonItemStyleBordered target:self action:@selector(handleTwoFingerTap:)];
        self.navigationItem.rightBarButtonItem = flipButton;
        [flipButton release];
    }
    

    //Escondemos la barra de navegación y colocamos el fondo de color negro.
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor blackColor];
    

  
    //Ajustes de Imagen y del ScrollView en la que en esta contenida.
    demoImageView.backgroundColor =[UIColor clearColor];
    scrollView.bouncesZoom = YES;
    scrollView.delegate = self;
    scrollView.clipsToBounds = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    demoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    demoImageView.contentMode = UIViewContentModeScaleAspectFit;
    demoImageView.userInteractionEnabled = YES;
    demoImageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
    demoImageView.image = [recipes.recipeImage valueForKey:@"recipeImage"];
    tarjeta1=demoImageView.image;
    tarjeta2=recipes.recipeThumbnailImage;
    //demoImageView.transform = CGAffineTransformMakeRotation(3.14/2);
    [scrollView setContentSize:CGSizeMake(demoImageView.frame.size.width, demoImageView.frame.size.height)];
    [scrollView addSubview:demoImageView];
    
    
    
    
    // add gesture recognizers to the image view
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    [demoImageView addGestureRecognizer:singleTap];
    [demoImageView addGestureRecognizer:doubleTap];
    [demoImageView addGestureRecognizer:twoFingerTap];
    
    
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    // float minimumScale = [scrollView frame].size.width  / [demoImageView frame].size.width;
    scrollView.maximumZoomScale = 6.0;
    scrollView.minimumZoomScale = 1.0;
    //scrollView.zoomScale = minimumScale;
    
    
    
}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return demoImageView;
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.navigationBarHidden==YES)
    {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        tiempoFoto=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(hideNavigationBar) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:tiempoFoto forMode:NSRunLoopCommonModes];
    }
    else{
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
}


//funcion que acerca la imagen al dar dos toques seguidos y aleja la siguiente vez
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (zoom==0)
    {
        // zoom in
        float newScale = [scrollView zoomScale] * ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [scrollView zoomToRect:zoomRect animated:YES];
        zoom++;
    }
    else{
        //zooms out
        float newScale = [scrollView zoomScale] / ZOOM_STEP;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [scrollView zoomToRect:zoomRect animated:YES];
        zoom=0;
    }
    
    
    
    
    
    
}

//funcion que da la vuelta a la tarjeta al pulsar la pantalla con dos dedos a la vez
- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    
    if(vuelta==0)
    {
        
        UIImage *secondImage = tarjeta2;
        [UIView transitionWithView:demoImageView duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               demoImageView.image = secondImage;
                           } completion:nil];
        vuelta=1;
    }
    else{
        UIImage *secondImage = tarjeta1;
        [UIView transitionWithView:demoImageView duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               demoImageView.image = secondImage;
                           } completion:nil];
        vuelta=0;
    }
    
}

#pragma mark Utility methods


//funcion que provoca que al hacer zoom la imagen siempre este centrada
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
           demoImageView.frame = CGRectMake(0,0, 320, 480);
        }
        if(result.height == 568)
        {
            demoImageView.frame = CGRectMake(0,0, 320, 570);
        }
    }
    
    
    demoImageView.contentMode = UIViewContentModeScaleAspectFit;
    demoImageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
  

    
}

//Esconde la navigationBar al salir del View
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=YES;



}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 /*   if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)){
        demoImageView.frame = CGRectMake(0,0, 320, 480);
        demoImageView.contentMode = UIViewContentModeScaleAspectFit;
        demoImageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
   
    }
    else{
        demoImageView.frame = CGRectMake(0,0, 480, 320);
        demoImageView.contentMode = UIViewContentModeScaleAspectFit;
        demoImageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
    } */
    // Return YES for everything but the portrait-upside-down orientation
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    

}



//Esta funcion esconde la barra y reinicia el temporizador de escondido/mostrar.
- (void)hideNavigationBar{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    if ([tiempoFoto isValid]) {
        [tiempoFoto invalidate];
    }
}


- (void)dealloc {
    [tiempoFoto release];
    tiempoFoto = nil;
    [super dealloc];
}

@end
