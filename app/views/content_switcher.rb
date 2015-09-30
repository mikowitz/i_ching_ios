class ContentSwitcher < UIView
  attr_accessor :contents, :headers
  attr_accessor :data_source

  def content_keys
    data_source.content_keys
  end

  def setup_content
    @header_control = rmq(self).append!(UISegmentedControl, :header_segmented_control).tap do |control|
      content_keys.each_with_index do |key, index|
        title = data_source.content_switcher(self, header_for_content_key: key)
        control.insertSegmentWithTitle(title, atIndex: index, animated: true)
      end
      control.addTarget(self,
                        action: :show_content,
                        forControlEvents: UIControlEventValueChanged)
    end
    draw_content
    @header_control.setSelectedSegmentIndex(0)
    show_content
  end

  def draw_content
    @contents = content_keys.map do |key|
      rmq(self).append(UILabel, :content).style do |st|
        st.text = data_source.content_switcher(self, content_for_content_key: key)
        st.resize_height_to_fit
        st.frame = { t: 40 }
      end
    end
  end

  def show_content
    rmq(self).animate(
      duration: 0.5,
      animations: -> (q) {
        @contents.each_with_index do |content, index|
          if index == @header_control.selectedSegmentIndex
            content.style do |st|
              st.layer.opacity = 1.0
            end
          else
            content.style do |st|
              st.layer.opacity = 0.0
            end
          end
        end
      }
    )
  end
end
