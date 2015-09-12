class PageTestScreen < UIPageViewController
  def self.new
    self.alloc.initWithTransitionStyle(
      UIPageViewControllerTransitionStyleScroll,
      navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal,
      options: {}
    )
  end

  def append_to(parent, controller)
    parent.addChildViewController(self)
    parent.rmq.append(self.view, :paginator)
    self.delegate = parent
    self.dataSource = parent

    self.setViewControllers(
      [controller],
      direction: UIPageViewControllerNavigationDirectionReverse,
      animated: false,
      completion: nil
    )
  end

  # def title
  #   self.viewControllers.first.title
  # end
end
