
#import "UIView+WQRadius.h"
#import <objc/runtime.h>

static NSOperationQueue *WQ_operationQueue;
static char WQ_operationKey;

@implementation UIView (RoundedCorner)

- (void)setShadowColor:(UIColor *)color shadowOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius shadowHeight:(CGFloat)height {
    //shadowColor阴影颜色
    self.layer.shadowColor = color.CGColor;
    //shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOffset = offset;
    //阴影透明度，默认0
    self.layer.shadowOpacity = opacity;
    //阴影半径，默认3
    self.layer.shadowRadius = radius;
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    float allWidth = self.bounds.size.width;
    float allHeight = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addShadowHeight = height;

    CGPoint topLeft = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x + (allWidth / 2.0),y - addShadowHeight);
    CGPoint topRight  = CGPointMake(x+allWidth,y);
    CGPoint rightMiddle = CGPointMake(x + allWidth + addShadowHeight,y + (allHeight / 2.0));
    CGPoint bottomRight  = CGPointMake(x + allWidth,y + allHeight);
    CGPoint bottomMiddle = CGPointMake(x + (allWidth / 2.0),y + allHeight + addShadowHeight);
    CGPoint bottomLeft   = CGPointMake(x,y + allHeight);
    CGPoint leftMiddle = CGPointMake(x - addShadowHeight,y + (allHeight / 2.0));
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft controlPoint:leftMiddle];
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}

- (void)setCornerRadius:(CGFloat)radius backgroundColor:(UIColor *)color {
    [self setCornerRadius:radius image:nil borderColor:nil borderWidth:0 backgroundColor:color contentMode:UIViewContentModeScaleAspectFill];
}

- (void)setCornerWQRadius:(WQRadius)radius backgroundColor:(UIColor *)color {
    [self setCornerWQRadius:radius image:nil borderColor:nil borderWidth:0 backgroundColor:color contentMode:UIViewContentModeScaleAspectFill];
}

- (void)setCornerRadius:(CGFloat)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    [self setCornerRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode];
}

- (void)setCornerWQRadius:(WQRadius)radius image:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    [self setCornerWQRadius:radius image:image borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode];
}

- (void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor {
    [self setCornerRadius:radius image:nil borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill];
}

- (void)setCornerWQRadius:(WQRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor {
    [self setCornerWQRadius:radius image:nil borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:UIViewContentModeScaleAspectFill];
}

- (void)setCornerRadius:(CGFloat)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode {
    [self setCornerWQRadius:WQRadiusMake(radius, radius, radius, radius) image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode];
}

+ (void)load {
    WQ_operationQueue = [[NSOperationQueue alloc] init];
}

- (NSOperation *)getOperation {
    id operation = objc_getAssociatedObject(self, &WQ_operationKey);
    return operation;
}

- (void)setCornerWQRadiusWithOperation:(NSOperation *)operation {
    objc_setAssociatedObject(self, &WQ_operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)WQ_cancelOperation {
    NSOperation *operation = [self getOperation];
    [operation cancel];
    [self setCornerWQRadiusWithOperation:nil];
}

- (void)setCornerWQRadius:(WQRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode {
    [self WQ_cancelOperation];
    
    [self setCornerWQRadius:radius image:image borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor contentMode:contentMode size:CGSizeZero forState:UIControlStateNormal completion:nil];
}

- (void)setCornerWQRadius:(WQRadius)radius image:(UIImage *)image borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state completion:(WQRoundedCornerCompletionBlock)completion {
    
    __block CGSize _size = size;
    
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        if ([[weakSelf getOperation] isCancelled]) return;
        
        if (CGSizeEqualToSize(_size, CGSizeZero)) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                _size = weakSelf.bounds.size;
            });
        }
        CGSize pixelSize = CGSizeMake(pixel(_size.width), pixel(_size.height));
        UIImage *currentImage = [UIImage setWQRadius:radius image:(UIImage *)image size:pixelSize borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            __strong typeof(weakSelf) self = weakSelf;
            if ([[self getOperation] isCancelled]) return;
            self.frame = CGRectMake(pixel(self.frame.origin.x), pixel(self.frame.origin.y), pixelSize.width, pixelSize.height);
            if ([self isKindOfClass:[UIImageView class]]) {
                ((UIImageView *)self).image = currentImage;
            } else if ([self isKindOfClass:[UIButton class]] && image) {
                [((UIButton *)self) setBackgroundImage:currentImage forState:state];
            } else if ([self isKindOfClass:[UILabel class]]) {
                self.layer.backgroundColor = [UIColor colorWithPatternImage:currentImage].CGColor;
            } else {
                self.layer.contents = (__bridge id _Nullable)(currentImage.CGImage);
            }
            if (completion) completion(currentImage);
        }];
    }];
    
    [self setCornerWQRadiusWithOperation:blockOperation];
    [WQ_operationQueue addOperation:blockOperation];
}

static inline CGFloat pixel(CGFloat num) {
    CGFloat unit = 1.0 / [UIScreen mainScreen].scale;
    CGFloat remain = fmod(num, unit);
    return num - remain + (remain >= unit / 2.0? unit: 0);
}

@end
