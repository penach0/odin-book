module ApplicationHelper
  def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join('_')
  end

  def link_to_feed(user)
    link_to user.identification,
            user_posts_path(user),
            data: { turbo: false }
  end

  def dropdown(button_text:, menu_position:, &block)
    content_tag(:div, class: "dropdown", data: { controller: "dropdown"}) do
      concat content_tag(:button, button_text, data: { action: "dropdown#toggle click@window->dropdown#lightDismiss"})
      concat content_tag(:div, capture(&block), class: ["menu", "menu--#{menu_position}"], data: { dropdown_target: "menu" })
    end
  end
end
