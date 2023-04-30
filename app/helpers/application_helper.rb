module ApplicationHelper
  def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join('_')
  end

  def link_to_feed(user)
    link_to user.identification,
            user_posts_path(user),
            data: { turbo: false }
  end
end
