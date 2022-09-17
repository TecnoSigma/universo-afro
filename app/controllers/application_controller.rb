class ApplicationController < ActionController::Base
  private

  def clear_session(session_type = nil)
    session_type ? session_type = nil : reset_session
  end
end
