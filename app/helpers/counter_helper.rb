module CounterHelper
  def stream_counter_update(model:, type:)
    turbo_stream.update nested_dom_id(model, "#{type}_counter") do
      p nested_dom_id(model, "#{type}_counter")
      content_tag(:span) do
        link_to "#{model.send(type).size} #{type}", "#" unless model.send(type).empty?
      end
    end
  end
end