module ApplicationHelper

  # Instead of 'render @thing' you can 'render_if(condition, thing)'
  def render_if(condition, record)
    if condition
      render record
    end
  end

end
