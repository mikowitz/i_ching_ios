class CastHexagramScreen < PM::Screen
  attr_accessor :lines, :stabilized

  def on_load
    rmq.stylesheet = CastingScreenStylesheet
    rmq(self.view).apply_style(:root_view)
    rmq(self.view).tap do |q|
      q.append!(HexagramView, :hexagram_view).tap do |hexagram_view|
        hexagram_view.delegate = self
        hexagram_view.lines = lines
      end.draw_lines
    end
    self.title = Hexagram.find(stabilized).chinese_name
  end

  def on_disappear
    rmq(:change_circle).style do |st|
      st.border_color = rmq.color.old_marker.CGColor
    end
    rmq(:change_x_line).style do |st|
      st.background_color = rmq.color.old_marker
    end
  end

  def show_info_for_line(title, message)
    alert = UIAlertController.alertControllerWithTitle(title,
                                                       message: message,
                                                       preferredStyle: UIAlertControllerStyleAlert)
    action = UIAlertAction.actionWithTitle("OK",
                                           style: UIAlertActionStyleCancel,
                                           handler: Proc.new { |_| clear_highlighted_line }.weak!)
    alert.addAction(action)
    presentViewController(alert, animated: true, completion: nil)
  end

  def clear_highlighted_line
    rmq(:change_circle).style do |st|
      st.border_color = rmq.color.old_marker.CGColor
    end
    rmq(:change_x_line).style do |st|
      st.background_color = rmq.color.old_marker
    end
  end
end
