//
//  RBTreeNode.m
//  RedBlack
//
//  Created by Richard on 11/23/13.
//
//

#import "RBTreeNode.h"

@implementation RBTreeNode

- (id)initWithValue:(id)value
{
    self = [super init];
    if (self) {
        _value = value;
        [self setColor:RED];
        [self setLeftChild:nil];
        [self setRightChild:nil];
    }
    
    return self;
}

- (id)initWithValue:(id)value color:(NSInteger)color
{
    self = [self initWithValue:value];
    if (self) {
        _color = color;
    }
    
    return self;
}

- (id)initWithValue:(id)value color:(NSInteger)color subtreeCount:(NSInteger)subtreeCount
{
    self = [self initWithValue:value color:color];
    if (self) {
        _subtreeCount = subtreeCount;
    }
    
    return self;
}

- (void)setLeftChild:(RBTreeNode *)leftChild
{
    _leftChild = leftChild;
    if (leftChild) {
        [leftChild setParent:self];
    }
}

- (void)setRightChild:(RBTreeNode *)rightChild
{
    _rightChild = rightChild;
    if (rightChild) {
        [rightChild setParent:self];
    }
}

- (void)setX:(NSInteger)x Y:(NSInteger)y
{
    [self setX: x];
    [self setY: y];
}

- (NSString *)toString
{
    NSString *pv = self.parent != nil ? [[self.parent value] stringValue] : @"np";
    NSString *lcv = self.leftChild != nil ? [[self.leftChild value] stringValue] : @"nlc";
    NSString *rcv = self.rightChild != nil ? [[self.rightChild value] stringValue] : @"nrc";
    NSString *string = [[NSString alloc] initWithFormat:@"V: %@ P: %@ C: %@ X: %ld Y:%ld lcv: %@ rcv: %@", self.value, pv, (self.color == RED ? @"r" : @"b"), _x, _y, lcv, rcv];
    return string;
}

@end
