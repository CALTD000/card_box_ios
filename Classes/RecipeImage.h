//
//  RecipeImage.h
//  Card Box
//
//  Created by Koldo Ruiz on 20/05/13.
//  
//

#import <CoreData/CoreData.h>

@class Recipes;

@interface RecipeImage :  NSManagedObject  
{
}

@property (nonatomic, retain) id recipeImage;
@property (nonatomic, retain) Recipes * recipe;

@end



