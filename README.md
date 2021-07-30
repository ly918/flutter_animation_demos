# ***Flutter Animation***

# 在 Flutter 中创建动画时可以采用不同的方法

* GIF动图
* Animation Framework package
    * Lottie: https://github.com/xvrh/lottie-flutter 
    * Flare: https://github.com/2d-inc/Flare-Flutter
>
* Code-based Animation
    * 隐式动画
    * 显示动画
    * CustomPainter
>
# 哪种方法适合您？考虑以下几点：
  * 动画看起来是否像绘图？
  * 是否想要用代码实现绘图动画？
  * 使用标准原语是否容易实现动画？
  * 代码实现是否困难？
  * 使用代码实现动画是否有性能问题？

# 隐式动画 Implicitly Animation
  ```
    class AnimatedFoo extends ImplicitlyAnimatedWidget {}
  ```
  * Align -> AnimatedAlign
  * Container -> AnimatedContainer
  * DefaultTextStyle -> AnimatedDefaultTextStyle
  * Opacity -> AnimatedOpacity
  * Padding -> AnimatedPadding
  * PhysicalModel -> AnimatedPhysicalModel
  * Positioned -> AnimatedPositioned
  * PositionedDirectional -> AnimatedPositionedDirectional
  * Theme -> AnimatedTheme

# 显式动画 Explicitly Animation
  ```
    class FooTransition extends AnimatedWidget {}
  ```
  * SizeTransition
  * FadeTransition
  * AlignTransition
  * ScaleTransition
  * Slideransition
  * RotationTransition
  * PositionedTransition 
  * DecoratedBoxTransition 
  * DefaultTextStyleTransition 
  * RelativePositionedTransition 

## 自定义显示动画
  * AnimatedWidget
  * AnimatedBuilder

# Animation
  ## Animation
  ```
  abstract class Animation<T> extends Listenable implements ValueListenable<T> {}
  ```
  * 

  ## AnimationController
  ```
  class AnimationController extends Animation<double> ... {}
  ```

# Tween


***引用***
* Docs: https://flutter.dev/docs/development/ui/animations

* Samples: https://flutter.github.io/samples/animations.html