// erkanyildiz
// 20150508-1752
//
// EYMaterialActivityIndicatorView.m

#import "EYMaterialActivityIndicatorView.h"

@implementation EYMaterialActivityIndicatorView
{
    UIView* rotator;
    CAShapeLayer* ring;
    
    CGFloat radius;
    CGFloat stroke;
    UIColor* color;

    CAMediaTimingFunction* curve;
    NSInteger offset;
    
    BOOL isAnimating;
}

#define D2R(angle) ((angle) * M_PI / 180.0)
static const CGFloat minimumArcInDegrees = 10;
static const CGFloat maximumArcInDegrees = 270;

static const CGFloat rotationDuration = 0.7;
static const CGFloat stretchDuration = 0.72;
static const CGFloat stretchDelay = 0.9775 * stretchDuration;
static const CGFloat shrinkDelay = 0.85 * stretchDuration;


- (instancetype)initWithCenter:(CGPoint)center;
{
    UIColor* defaultColor = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1];
    return [self initWithCenter:center radius:20 stroke:4 andColor:defaultColor];
}


- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)_radius stroke:(CGFloat)_stroke andColor:(UIColor *)_color;
{
    self = [super initWithFrame:(CGRect){center.x - _radius, center.y - _radius, _radius * 2, _radius * 2}];
    
    if(self)
    {
        radius = _radius;
        stroke = _stroke;
        color = _color;
        curve = [CAMediaTimingFunction functionWithControlPoints:0.72 :0.0 :0.28 :1.0];
        offset = -(maximumArcInDegrees - minimumArcInDegrees);

        rotator = [UIView.alloc initWithFrame:self.bounds];
        rotator.backgroundColor = UIColor.clearColor;
        [self addSubview:rotator];
    
        [self startAnimating];
    }
    
    return self;
}


#pragma mark -


- (void)startAnimating
{
    if(!isAnimating)
    {
        isAnimating = YES;
        self.alpha = 1.0;
        [self stretch];
        [self rotate];
    }
}


- (void)stopAnimating
{
    if(isAnimating)
    {
        [UIView animateWithDuration:rotationDuration*0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            self.alpha = 0.0;
        } 
        completion:^(BOOL finished) 
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(shrink) object:nil];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stretch) object:nil];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(rotate) object:nil];
            [self.layer removeAllAnimations];
            isAnimating = NO;
        }];
    }
}


- (BOOL)isAnimating
{
    return isAnimating;
}


#pragma mark -


-(void)stretch
{
    offset += (maximumArcInDegrees - minimumArcInDegrees);
    offset %= 360;
    float offsetf = (float)offset - 90.0 - 0.5 * minimumArcInDegrees;
    
    [ring removeFromSuperlayer];
    ring = CAShapeLayer.layer;
    ring.path = [UIBezierPath bezierPathWithArcCenter:rotator.center radius:radius startAngle:D2R(offsetf) endAngle:D2R(offsetf + maximumArcInDegrees) clockwise:YES].CGPath;
    ring.position = CGPointZero;
    ring.fillColor = UIColor.clearColor.CGColor;
    ring.strokeColor = color.CGColor;
    ring.lineWidth = stroke;
    ring.lineCap = kCALineCapSquare;
    [rotator.layer addSublayer:ring];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.duration = stretchDuration;
    anim.repeatCount = 1.0;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.fromValue = @(minimumArcInDegrees/maximumArcInDegrees);
    anim.toValue = @(1.0);
    anim.timingFunction = curve;
    [ring addAnimation:anim forKey:@"stretchAnim"];

    [self performSelector:@selector(shrink) withObject:nil afterDelay:shrinkDelay];
}


-(void)shrink
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    anim.duration = stretchDuration;
    anim.repeatCount = 1.0;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0-minimumArcInDegrees/maximumArcInDegrees);
    anim.timingFunction = curve;
    [ring addAnimation:anim forKey:@"shrinkAnim"];

    [self performSelector:@selector(stretch) withObject:nil afterDelay:stretchDelay];
}


-(void)rotate
{
    [UIView animateWithDuration:rotationDuration delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{ rotator.transform = CGAffineTransformRotate(rotator.transform, M_PI); }
                     completion:nil];

    [self performSelector:@selector(rotate) withObject:nil afterDelay:rotationDuration];
}

@end
