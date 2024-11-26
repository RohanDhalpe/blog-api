# frozen_string_literal: true

module BlogService
  class Create < Base
    attr_reader :params

    def initialize(params)
      super()
      @params = params
    end

    def call
      return failure_response(message, errors) unless create_blog

      set_data
      success_response(message, data)
    end

    private

    def create_blog
      @blog = Blog.new(blog_params)
      return true if @blog.save

      @message = I18n.t('model.create.failure', model_name: 'Blog')
      @errors = @blog.errors.full_messages
      false
    end

    def set_data
      @message = I18n.t('model.create.success', model_name: 'Blog')
      @data = BlogSerializer.new(@blog)
    end

    def blog_params
      params.require(:blog).permit(:title, :content, :category, :user_id)
    end
  end
end
