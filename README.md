# **_Flutter Animation_**

# 在 Flutter 中创建动画时可以采用不同的方法

- GIF 动图
- Animation Framework package
  _ Lottie: https://github.com/xvrh/lottie-flutter
  _ Flare: https://github.com/2d-inc/Flare-Flutter
  >
- Code-based Animation
  _ 隐式动画
  _ 显示动画 \* CustomPainter
  >

# 哪种方法适合您？考虑以下几点：

- 动画看起来是否像绘图？
- 是否想要用代码实现绘图动画？
- 使用标准原语是否容易实现动画？
- 代码实现是否困难？
- 使用代码实现动画是否有性能问题？

# 隐式动画 Implicitly Animation

```
  class AnimatedFoo extends ImplicitlyAnimatedWidget {}
```

- Align -> AnimatedAlign
- Container -> AnimatedContainer
- DefaultTextStyle -> AnimatedDefaultTextStyle
- Opacity -> AnimatedOpacity
- Padding -> AnimatedPadding
- PhysicalModel -> AnimatedPhysicalModel
- Positioned -> AnimatedPositioned
- PositionedDirectional -> AnimatedPositionedDirectional
- Theme -> AnimatedTheme

# 显式动画 Explicitly Animation

```
  class FooTransition extends AnimatedWidget {}
```

- SizeTransition
- FadeTransition
- AlignTransition
- ScaleTransition
- SlideTransition
- RotationTransition
- PositionedTransition
- DecoratedBoxTransition
- DefaultTextStyleTransition
- RelativePositionedTransition

## 自定义显示动画

- AnimatedWidget
- AnimatedBuilder

# Animation

> Flutter 中的动画系统基于 Animation 对象的，widget 可以在 build 函数中读取 Animation 对象的当前值， 并且可以监听动画的状态改变。

```
abstract class Animation<T> extends Listenable implements ValueListenable<T> {}
```

## Animation

- Flutter 动画库中的一个核心类，它生成指导动画的值。

- 对象知道动画的当前状态（例如，它是开始、停止还是向前或向后移动），但它不知道屏幕上显示的内容。

`Animation<double>`

- 在 Flutter 中，Animation 对象本身和 UI 渲染没有任何关系。Animation 是一个抽象类，它拥有其当前值和状态（完成或停止）。其中一个比较常用的 Animation 类是 Animation<double>。

- Flutter 中的 Animation 对象是一个在一段时间内依次生成一个区间之间值的类。Animation 对象的输出可以是线性的、曲线的、一个步进函数或者任何其他可以设计的映射。 根据 Animation 对象的控制方式，动画可以反向运行，甚至可以在中间切换方向。

- Animation 还可以生成除 double 之外的其他类型值，如：Animation<Color> 或 Animation<Size>。

- Animation 对象有状态。可以通过访问其 value 属性获取动画的当前值。

`CurvedAnimation`

```
class CurvedAnimation extends Animation<double> with AnimationWithParentMixin<double> {}
```

- 将过程抽象为一个非线性曲线.

- 定义：https://api.flutter.dev/flutter/animation/Curves-class.html

- 自定义 Curve

```
class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(t * math.PI * 2);
  }
}
```

`AnimationController`

```
class AnimationController extends Animation<double> ... {}
```

- 管理 Animation

- AnimationController 是一个特殊的 Animation 对象，在屏幕刷新的每一帧，就会生成一个新的值。默认情况下，AnimationController 在给定的时间段内会线性的生成从 0.0 到 1.0 的数字。 例如，下面代码创建一个 Animation 对象，但不会启动它运行：

```
final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 2000), vsync: this);
```

- AnimationController 派生自 Animation<double>，因此可以在需要 Animation 对象的任何地方使用。 但是，AnimationController 具有控制动画的其他方法。例如，.forward()方法可以启动动画。数字的产生与屏幕刷新有关，因此每秒钟通常会产生 60 个数字，在生成每个数字后，每个 Animation 对象调用添加的 Listener 对象。

- 当创建一个 AnimationController 时，需要传递一个 vsync 参数，存在 vsync 时会防止屏幕外动画（译者语：动画的 UI 不在当前屏幕时）消耗不必要的资源。 通过将 SingleTickerProviderStateMixin 添加到类定义中，可以将 stateful 对象作为 vsync 的值。

- vsync 对象会绑定动画的定时器到一个可视的 widget，所以当 widget 不显示时，动画定时器将会暂停，当 widget 再次显示时，动画定时器重新恢复执行，这样就可以避免动画相关 UI 不在当前屏幕时消耗资源。 如果要使用自定义的 State 对象作为 vsync 时，请包含 TickerProviderStateMixin。

> **_注意： 在某些情况下，值(position，值动画的当前值)可能会超出 AnimationController 的 0.0-1.0 的范围。例如，fling()函数允许您提供速度(velocity)、力量(force)、position(通过 Force 对象)。位置(position)可以是任何东西，因此可以在 0.0 到 1.0 范围之外。 CurvedAnimation 生成的值也可以超出 0.0 到 1.0 的范围。根据选择的曲线，CurvedAnimation 的输出可以具有比输入更大的范围。例如，Curves.elasticIn 等弹性曲线会生成大于或小于默认范围的值。_**

# Tween

- 在正在执行动画的对象所使用的数据范围之间生成值。例如，Tween 可能会生成从红到蓝之间的色值，或者从 0 到 255。

```
class Tween<T extends dynamic> extends Animatable<T> {}
```

- 默认情况下，AnimationController 对象的范围从 0.0 到 1.0。如果您需要不同的范围或不同的数据类型，则可以使用 Tween 来配置动画以生成不同的范围或数据类型的值。例如，以下示例，Tween 生成从-200.0 到 0.0 的值：

```
final Tween doubleTween = new Tween<double>(begin: -200.0, end: 0.0);
```

- Tween 是一个无状态(stateless)对象，需要 begin 和 end 值。Tween 的唯一职责就是定义从输入范围到输出范围的映射。输入范围通常为 0.0 到 1.0，但这不是必须的。

- Tween 继承自 Animatable<T>，而不是继承自 Animation<T>。Animatable 与 Animation 相似，不是必须输出 double 值。例如，ColorTween 指定两种颜色之间的过渡。

```
final Tween colorTween =
    new ColorTween(begin: Colors.transparent, end: Colors.black54);
```

- Tween 对象不存储任何状态。相反，它提供了 evaluate(Animation<double> animation)方法将映射函数应用于动画当前值。 Animation 对象的当前值可以通过 value()方法取到。evaluate 函数还执行一些其它处理，例如分别确保在动画值为 0.0 和 1.0 时返回开始和结束状态。

`Tween.animate`

- 要使用 Tween 对象，请调用其 animate()方法，传入一个控制器对象。例如，以下代码在 500 毫秒内生成从 0 到 255 的整数值。

```
final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this);
Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(controller);
```

> 注意 animate()返回的是一个 Animation，而不是一个 Animatable。

- 以下示例构建了一个控制器、一条曲线和一个 Tween：

```
final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 500), vsync: this);
final Animation curve =
    new CurvedAnimation(parent: controller, curve: Curves.easeOut);
Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(curve);
```

`动画通知`

- 一个 Animation 对象可以拥有 Listeners 和 StatusListeners 监听器，可以用 addListener()和 addStatusListener()来添加。 只要动画的值发生变化，就会调用监听器。一个 Listener 最常见的行为是调用 setState()来触发 UI 重建。动画开始、结束、向前移动或向后移动（如 AnimationStatus 所定义）时会调用 StatusListener。

## 动画示例

`用 AnimatedWidget 简化`

- 如何使用 AnimatedWidget 助手类（而不是 addListener()和 setState()）来给 widget 添加动画

- 使用 AnimatedWidget 创建一个可重用动画的 widget。要从 widget 中分离出动画过渡，请使用 AnimatedBuilder。

- Flutter API 提供的关于 AnimatedWidget 的示例包括：AnimatedBuilder、AnimatedModalBarrier、DecoratedBoxTransition、FadeTransition、PositionedTransition、RelativePositionedTransition、RotationTransition、ScaleTransition、SizeTransition、SlideTransition。

- AnimatedWidget 类允许您从 setState()调用中的动画代码中分离出 widget 代码。AnimatedWidget 不需要维护一个 State 对象来保存动画。

- 在下面的重构示例中，LogoApp 现在继承自 AnimatedWidget 而不是 StatefulWidget。AnimatedWidget 在绘制时使用动画的当前值。LogoApp 仍然管理着 AnimationController 和 Tween。

```
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new AnimatedLogo(animation: animation);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(new LogoApp());
}
```

- LogoApp 将 Animation 对象传递给基类并用 animation.value 设置容器的高度和宽度，因此它的工作原理与之前完全相同。

- 和 animate1 中不同的是，AnimatedWidget(基类)中会自动调用 addListener()和 setState()。

`监视动画的过程 `

- 使用 addStatusListener 来处理动画状态更改的通知，例如启动、停止或反转方向。

- 当动画完成或返回其开始状态时，通过反转方向来无限循环运行动画

`知道动画何时改变状态通常很有用的，如完成、前进或倒退。你可以通过 addStatusListener()来得到这个通知。 以下代码修改 animate1 示例，以便它监听动态状态更改并打印更新。 下面高亮显示的部分为修改的：`

```
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addStatusListener((state) => print("$state"));
    controller.forward();
  }
  //...
}
```

`运行此代码将输出以下内容：`

```
AnimationStatus.forward
AnimationStatus.completed
```

`接下来，使用 addStatusListener()在开始或结束时反转动画。这产生了循环效果：`

```
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }
  //...
}
```

`用AnimatedBuilder重构`

- AnimatedBuilder 了解如何渲染过渡.
- An AnimatedBuilder 不知道如何渲染 widget，也不知道如何管理 Animation 对象。
- 使用 AnimatedBuilder 将动画描述为另一个 widget 的 build 方法的一部分。如果你只是想用可复用的动画定义一个 widget，请使用 AnimatedWidget。
- Flutter API 中 AnimatedBuilder 的示例包括: BottomSheet、ExpansionTile、 PopupMenu、ProgressIndicator、RefreshIndicator、Scaffold、SnackBar、TabBar、TextField。

`并行动画`

**_引用_**

- Docs: https://flutter.dev/docs/development/ui/animations

- Samples: https://flutter.github.io/samples/animations.html
