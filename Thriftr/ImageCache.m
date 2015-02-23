#import "ImageCache.h"


@implementation  ImageCache

- (NSInteger)sizeOf:(NSString *)key value:(id)value
{
    UIImage *img = (UIImage *)value;
    CGSize size = img.size;
    return (NSInteger)ceil(size.height * size.width * img.scale * 4);
}


@end