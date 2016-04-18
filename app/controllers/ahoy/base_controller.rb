module Ahoy
  class BaseController < ActionController::Base

    if respond_to?(:before_action)
      before_action :verify_request_size
    else
      before_filter :verify_request_size
    end

    protected

    def ahoy
      @ahoy ||= Ahoy::Tracker.new(controller: self, api: true)
    end

    def verify_request_size
      if request.content_length > Ahoy.max_content_length
        logger.info "[ahoy] Payload too large"
        render text: "Payload too large\n", status: 413
      end
    end
  end
end
