module VisitCount

    private

  def index_counter
    session[:index_counter].nil? ? session[:index_counter] = 1 : session[:index_counter] += 1
  end

  def reset_counter
    session[:index_counter] = 0
  end

end