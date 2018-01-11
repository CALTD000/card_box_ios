//
//  Recipes.h
//  Card Box
//
//  Created by Koldo Ruiz on 20/05/13.
//  
//

#import <CoreData/CoreData.h>

@class RecipeImage;
@class RecipeImage2;

@interface UIImageToDataTransformer : NSValueTransformer {
}
@end

@interface Recipes :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * recipeName;
@property (nonatomic, retain) NSString * cookingTime;
@property (nonatomic, retain) id recipeThumbnailImage;
@property (nonatomic, retain) RecipeImage * recipeImage;

@end



