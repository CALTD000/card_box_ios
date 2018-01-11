// 
//  Recipes.m
//  Card Box
//
//  Created by Koldo Ruiz on 20/05/13.
//  
//

#import "Recipes.h"

#import "RecipeImage.h"

@implementation Recipes 

@dynamic recipeName;
@dynamic cookingTime;
@dynamic recipeThumbnailImage;
@dynamic recipeImage;

+ (void)initialize {
	if (self == [Recipes class] ) {
		UIImageToDataTransformer *transformer = [[UIImageToDataTransformer alloc] init];
		[NSValueTransformer setValueTransformer:transformer forName:@"UIImageToDataTransformer"];
	}
}


@end

@implementation UIImageToDataTransformer


+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	NSData *data = UIImagePNGRepresentation(value);
	return data;
}


- (id)reverseTransformedValue:(id)value {
	UIImage *uiImage = [[UIImage alloc] initWithData:value];
	return [uiImage autorelease];
}

@end
