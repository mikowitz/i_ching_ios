class CastingScreen < PM::Screen
  attr_accessor :lines, :stabilized, :changed
  attr_accessor :current_screen, :next_controller

  def on_load
    rmq.stylesheet = HexagramScreenStylesheet
    rmq(self.view).style do |st|
      st.background_color = rmq.color.off_white
    end
    self.title = Hexagram.find(stabilized).chinese_name
    self.current_screen = controllers[1]
    @carousel = PageTestScreen.new
    @carousel.append_to(self, self.current_screen)
  end

  def controllers
    @controllers ||= [
      HexagramScreen.new(nav_bar: true, hexagram: Hexagram.find(stabilized)),
      CastHexagramScreen.new(nav_bar: true, lines: lines, stabilized: stabilized),
      HexagramScreen.new(nav_bar: true, hexagram: Hexagram.find(changed))
    ]
  end

  def pageViewController(_, willTransitionToViewControllers: controllers)
    self.next_controller = controllers[0]
  end

  def pageViewController(_, didFinishAnimating: _, previousViewControllers: _, transitionCompleted: completed)
    if completed
      self.title = self.next_controller.title
    end
  end

  def pageViewController(_, viewControllerBeforeViewController: vc)
    index = controller_index(vc)

    return nil if index < 1
    controllers[index - 1]
  end

  def pageViewController(_, viewControllerAfterViewController: vc)
    index = controller_index(vc)
    return nil if index == controllers.size - 1

    controllers[index + 1]
  end

  def presentationCountForPageViewController(pageViewController)
    controllers.size
  end

  def presentationIndexForPageViewController(pageViewController)
    return 1
  end

  private

  def controller_index(controller)
    controllers.index(controller)
  end
end
