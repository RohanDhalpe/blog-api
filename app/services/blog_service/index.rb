# frozen_string_literal: true

module BlogService
  class Index < Base
    attr_reader :params, :blogs

    def initialize(params)
      super()
      @params = params
      @blogs = Blog.all
    end

    def call
      filter_blogs
      return failure_response(message, errors) unless blogs.present?

      success_response(message, data)
    end

    private

    def filter_blogs
      @blogs = blogs.where(user_id: @params[:user_id]) if @params[:user_id].present?
      @blogs = blogs.where(category: @params[:category]) if @params[:category].present?

      @message = blogs.present? ? I18n.t('model.found.success', model_name: 'Blog') : I18n.t('model.found.failure', model_name: 'Blog')
    end

    def data
      ActiveModelSerializers::SerializableResource.new(blogs, each_serializer: BlogSerializer)
    end
  end
end
