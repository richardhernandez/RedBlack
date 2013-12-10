//
//  RBNodeView.m
//  RedBlack
//
//  Created by Richard on 11/27/13.
//
//

#import "RBNodeView.h"

@implementation RBNodeView

- (id)initWithTitle:(NSString *)title Color:(NSInteger)color X:(CGFloat)x Y:(CGFloat)y
{
    self = [super initWithFrame:CGRectMake(x, y, CIRCLE_SIZE, CIRCLE_SIZE)];
    if (self) {
        _title = title;
        _color = color == RED ? [UIColor redColor] : [UIColor blackColor];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}
- (id)initWithRBTreeNode:(RBTreeNode *)node
{
    self = [self initWithTitle:[[node value] stringValue] Color:[node color] X:[node x] Y:[node y]];
    if (self) {
        self.node = node;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect c = CGRectMake(rect.origin.x, rect.origin.y, CIRCLE_SIZE, CIRCLE_SIZE);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, _color.CGColor);
    CGContextFillEllipseInRect(context, c);
    CGPoint p = CGPointMake(rect.origin.x + CIRCLE_SIZE / 4, rect.origin.y + CIRCLE_SIZE / 4);
    [_title drawAtPoint:p withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

@end
