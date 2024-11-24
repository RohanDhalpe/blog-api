# frozen_string_literal: true

class Base
  attr_accessor :message, :data, :errors

  def initialize
    @message = ''
    @data = {}
    @errors = []
  end

  def success_response(message, data = {})
    {
      success: true,
      message: message,
      data: data
    }
  end

  def failure_response(message, errors = [])
    {
      success: false,
      message: message,
      errors: errors
    }
  end
end
