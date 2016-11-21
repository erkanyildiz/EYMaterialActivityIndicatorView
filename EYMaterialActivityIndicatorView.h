// erkanyildiz
// 20150508-1752
//
// EYMaterialActivityIndicatorView.h

#import <UIKit/UIKit.h>

@interface EYMaterialActivityIndicatorView : UIView

/**
 * Initializes and returns an activity indicator object stylized using default values, and starts the animation.
 * @discussion Default style radius is 20.0, stroke width is 4.0 and color is RGB(3,169,244).
 * @param center Center position of the activity indicator
 * @return An initialized EYMaterialActivityIndicatorView object or nil if the object couldn’t be created.
 */
- (instancetype)initWithCenter:(CGPoint)center;

/**
 * Initializes and returns an activity indicator object customly stylized using passed values, and starts the animation.
 * @param center Center position of the activity indicator
 * @param radius Outer radius of the activity indicator
 * @param stroke Stroke width of the activity indicator
 * @param color Stroke color of the activity indicator
 * @return An initialized EYMaterialActivityIndicatorView object or nil if the object couldn’t be created.
 */
- (instancetype)initWithCenter:(CGPoint)center radius:(CGFloat)radius stroke:(CGFloat)stroke andColor:(UIColor *)color;

/**
 * Starts the animation of the activity indicator. If animation is already started calling this method has no effect.
 */
- (void)startAnimating;

/**
 * Stops the animation of the activity indicator and hides it using alpha value. If animation is already stopped calling this method has no effect.
 */
- (void)stopAnimating;

/**
 * Returns whether the activity indicator is animating.
 * @return YES if animating, otherwise NO.
 */
- (BOOL)isAnimating;
@end
