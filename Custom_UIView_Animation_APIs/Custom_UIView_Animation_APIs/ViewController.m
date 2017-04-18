//
//  ViewController.m
//  Custom_UIView_Animation_APIs
//
//  Created by 严锦龙 on 17/4/19.
//  Copyright © 2017年 moonbasa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /* UIView 默认情况下禁止了 layer 动画，但是在 animation block 中又重新启用了它们
     
        无论何时一个可动画的 layer 属性改变时，layer 都会寻找并运行合适的 'action' 来实行这个改变。在 Core Animation 的专业术语中就把这样的动画统称为动作 (action，或者 CAAction)。
     
     layer 通过向它的 delegate 发送 actionForLayer:forKey: 消息来询问提供一个对应属性变化的 action。delegate 可以通过返回以下三者之一来进行响应：
     
     它可以返回一个动作对象，这种情况下 layer 将使用这个动作。
     它可以返回一个 nil， 这样 layer 就会到其他地方继续寻找。
     它可以返回一个 NSNull 对象，告诉 layer 这里不需要执行一个动作，搜索也会就此停止。
     而让这一切变得有趣的是，当 layer 在背后支持一个 view 的时候，view 就是它的 delegate；
     
     理解这些之后，前一分钟解释起来还复杂无比的现象瞬间就易如反掌了：属性改变时 layer 会向 view 请求一个动作，而一般情况下 view 将返回一个 NSNull，只有当属性改变发生在动画 block 中时，view 才会返回实际的动作。
     
     运行上面的代码，可以看到在 block 外 view 返回的是 NSNull 对象，而在 block 中时返回的是一个 CABasicAnimation。很优雅，对吧？值得注意的是打印出的 NSNull 是带着一对尖括号的 ("<null>")，这和其他对象一样，而打印 nil 的时候我们得到的是普通括号((null))：
     */
    NSLog(@"outside animation block: %@",
          [self.myView actionForLayer:self.myView.layer forKey:@"position"]);
    
    [UIView animateWithDuration:0.3 animations:^{
        NSLog(@"inside animation block: %@",
              [self.myView actionForLayer:self.myView.layer forKey:@"position"]);
    }];
}

- (UIView *)myView {
    if (!_myView) {
        _myView = [[UIView alloc] initWithFrame:CGRectMake(50, 90, 90, 60)];
        _myView.backgroundColor = [UIColor redColor];
    }
    
    return _myView;
}

@end
