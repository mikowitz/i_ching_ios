class CastPageViewScreen < UIPageViewController
  def self.new
    self.alloc.initWithTransitionStyle(
      UIPageViewControllerTransitionStyleScroll,
      navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal,
      options: {}
    )
  end

  def append
    self.delegate.addChildViewController(self)
    self.delegate.rmq.append(self.view, :paginator)

    self.setViewControllers(
      [self.dataSource.controllers[1]],
      direction: UIPageViewControllerNavigationDirectionReverse,
      animated: false,
      completion: nil
    )
  end
end
