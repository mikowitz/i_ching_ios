class HomeScreen < PM::Screen
  # title "Your title here"
  # stylesheet HomeScreenStylesheet

  def on_load
    rmq.stylesheet = HexagramScreenStylesheet
    rmq(self.view).style do |st|
      st.background_color = rmq.color.off_white
    end
    @carousel = PageTestScreen.new
    @carousel.append_to(self, controllers[1])
  end

  def controllers
    @controllers ||= [
      # PM::Screen.new.tap do |screen|
      #   rmq(screen.view).style { |st| st.background_color = rmq.color.red }
      # end,
      # PM::Screen.new.tap do |screen|
      #   rmq(screen.view).style { |st| st.background_color = rmq.color.blue }
      # end,
      # PM::Screen.new.tap do |screen|
      #   rmq(screen.view).style { |st| st.background_color = rmq.color.green }
      # end
    ]
  end


  def index_of_controller(controller)
    controllers.index(controller)
  end

  def pageViewController(pvc, viewControllerBeforeViewController: vc)
    index = index_of_controller(vc)

    return nil if index < 1
    controllers[index - 1]
  end

  def pageViewController(pvc, viewControllerAfterViewController:vc)
    index = index_of_controller(vc)
    return nil if index == controllers.size - 1

    controllers[index + 1]
  end

  def presentationCountForPageViewController(pageViewController)
    controllers.size
  end

  def presentationIndexForPageViewController(pageViewController)
    return 0
  end
end
