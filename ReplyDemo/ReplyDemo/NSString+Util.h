//
//  NSString+Util.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ISNullOrEmpty(x) ((x) == nil || [(x) isEmpty])

@interface NSString (Util)
- (bool)isEmpty;
- (NSString *)trim;
- (NSNumber *)numericValue;
- (CGSize)suggestedSizeWithFont:(UIFont *)font width:(CGFloat)width;
-(NSDictionary *)traslateArabNumToStrDic;
@end



@interface NSString(JSONCategories)
-(id)JSONValue;
@end
