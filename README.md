# EYMaterialActivityIndicatorView
Material Design style Activity Indicator View for iOS replicating [circular indeterminate progress indicator](https://material.google.com/components/progress-activity.html#progress-activity-types-of-indicators).

#Usage

Similar to UIActivityIndicatorView:

```
//For default style just specify the center position for the indicator:
EYMaterialActivityIndicatorView* v = [EYMaterialActivityIndicatorView.alloc initWithCenter:(CGPoint){100,150}];
    

//Or for custom style specify radius, stroke and color, in addition to center:
EYMaterialActivityIndicatorView* v = [EYMaterialActivityIndicatorView.alloc initWithCenter:(CGPoint){100,150} radius:40 stroke:10 andColor:UIColor.redColor];


//And add it as usual
[self.view addSubview:v];
```


#How It Looks

Default style radius is 20.0, stroke width is 4.0 and color is RGB(3,169,244).

<img src="https://cloud.githubusercontent.com/assets/1222652/17806672/d724a084-6640-11e6-8dfa-995381e419ac.gif" width="320" height="320">