# frozen_string_literal: true

module UserService
  class Create < Base
    attr_reader :params

    def initialize(params)
      super()
      @params = params
    end

    def call
      return failure_response(message, errors) unless create_user

      set_data
      success_response(message, data)
    end

    private

    def create_user
      @user = User.new(user_params)
      if @user.save
        true
      else
        @message = I18n.t('model.create.failure', model_name: 'User')
        @errors = @user.errors.full_messages
        false
      end
    end

    def set_data
      @message = I18n.t('model.create.success', model_name: 'User')
      @data = UserSerializer.new(@user)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :dob, :gender, :country, :city)
    end
  end
end
