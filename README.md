# DelegateDemo
使用Delegate在界面间传递信息的例子

在开发应用的过程中，我们需要频繁地在界面之间传递消息，有时候是传递信息，有时候是传递一个信号即可。在iOS开发中，有多种传递信息的方式。比如最简单的，如果我们要在从一个界面进入另一个界面时给新界面传递一些消息，只需要给新界面定义一些属性，然后在创建新界面的时候设置其属性值即可。

那么如果要从新界面反过来传递信息给原先的界面怎么做呢，怎么建立起一个沟通的桥梁呢？iOS也提供了很多种方式，比如Notification、Block、UserDefault等等。本文就讲解最常见也是最常用的一种方式，几乎每个学习了一段iOS开发的人都见过也用过，只是可能不明白，那就是Delegate——委托。

回想一下，在使用列表，也就是UITableView的时候，除了创建这个列表对象，还会用到UITableView Datasource和UITableView Delegate。当我们要设置点击列表行的相应时，就要用到UITableView Delegate的方法，这里要讲的，跟这个是同一个东西。

先看一个效果：
![](https://github.com/Cloudox/DelegateDemo/blob/master/delegate.gif)

在主界面有一个按钮和一个方块，方块原本是隐藏的。进入子界面，子界面有两个按钮，一个用来告诉主界面显示方块，一个用来告诉主界面隐藏方块。那子界面时怎么告诉主界面的呢？

抽象地说，delegate就是一个协议。这个协议由子界面定下规矩，比如点击显示方块的按钮会如何，点击隐藏的按钮又会如何。任何界面都可以声明我要遵循子界面的这个协议。然后当在子界面触发协议内容，也就是这里的点击两个按钮时，遵循协议的界面，这里就是主界面，就会收到一个信号，然后进行相应的操作即可。这个信号可以包含一些信息，比如各种对象：字符串、图片、数据流等等，也可以不包含信息，仅仅是一个信号。这个例子中就仅仅是不包含信息的信号，比如要显示方块的信号和要隐藏方块的信号。

来看看代码：

先看子界面，我们说子界面要定下规矩，首先要在.h文件中声明规矩：

```objective-c
@protocol SecondViewControllerDelegate
- (void)showTheSquare;// 显示方块的委托
- (void)dismissTheSquare;// 隐藏方块的委托
@end

@interface SecondViewController : UIViewController

@property (nonatomic, weak) id<SecondViewControllerDelegate> delegate;// 声明delegate对象

@end
```

可以看到，子界面首先定义了两个协议，一个表示显示方块，一个表示隐藏方块，其本质是两个方法。然后声明了一个属性，同声明其他对象一样，只不过这里是一个delegate对象，其类型为我们上面声明的协议类型。

定下规矩名后，我们要在点击按钮的时候去使用规矩，所以在.m文件中：

```objective-c
// 显示方块
- (void)showSquare {
    [self.delegate showTheSquare];// 调用委托方法
    [self.navigationController popViewControllerAnimated:YES];// 返回上个界面
}

// 隐藏方块
- (void)dismissSquare {
    [self.delegate dismissTheSquare];// 调用委托方法
    [self.navigationController popViewControllerAnimated:YES];// 返回上个界面
}
```

在两个按钮的响应方法中，分别用delegate对象调用了定下的两个委托方法。这样子界面的工作就做完了。

回到主界面，我们之前说，主界面要表示我遵循子界面定下的规矩，怎么声明呢？和使用UITableView对象时的做法一样，在.m文件的开头表示一下就好：

```objective-c
// 遵循子界面的协议
@interface ViewController ()<SecondViewControllerDelegate>
```

这里的协议名就是我们在子界面中声明协议时定下的名字，还记得吧，这个协议中我们定下了两个方法，分别表示显示和隐藏方块。另外要特别注意不能忘记的是，在创建子界面的时候，要将子界面的属性——delegate对象，设为self：

```objective-c
// 进入子界面
- (void)showSecondView {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.delegate = self;
    [self.navigationController pushViewController:secondVC animated:YES];
}
```

这其实就跟我们用UITableView时要把tableView的delegate和datasource都设为self是一个道理，这样才能收到消息。

好了。我们之前已经在子界面中设置了，点击两个按钮会调用那两个方法，但是这两个方法具体要做什么，确实在主界面中设置的。因为任何界面都可以遵循使用这些协议方法，而每个界面的需求是不一样的，子界面只负责喊话说我要调用这个方法了，具体方法干什么还是在主界面中实现，这里我们就是显示和隐藏方块：

```objective-c
#pragma mark - SecondViewController Delegate

// 显示方块
- (void)showTheSquare {
    self.square.alpha = 1;
}

// 隐藏方块
- (void)dismissTheSquare {
    self.square.alpha = 0;
}
```

这样就可以实现上面动图的效果了，也就是说，子界面成功地把信号传递回了主界面，称为回调。如果你在自己的开发中发现没有效果，最可能的就是忘记将delegate属性设为self了，这样是收不到信号的。

我们最开始也说了，有时候只需要传递信号，而有时候需要传递一些具体的信息对象，那要怎么做呢？其实也很简单，我们的协议不是规定了很多方法吗，在这些方法里加上参数就可以把数据对象当参数传递了~


----------
查看博客：[http://blog.csdn.net/cloudox_](http://blog.csdn.net/cloudox_)
