//
//  NSString+Util.m
//

#import "NSString+Util.h"


@implementation NSString (Util)

- (bool)isEmpty {
    return self.length == 0;
}

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *)numericValue {
    return [NSNumber numberWithUnsignedLongLong:[self longLongValue]];
}

- (CGSize)suggestedSizeWithFont:(UIFont *)font width:(CGFloat)width {
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return bounds.size;
}



-(NSDictionary *)traslateArabNumToStrDic{
  
   return  @{@"1":@"星期一",@"2":@"星期二",@"3":@"星期三",@"4":@"星期四",@"5":@"星期五",@"6":@"星期六",@"7":@"星期日"};
        

}
@end

@implementation NSString(JSONCategories)

-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
