# frozen_string_literal: true

module BlogService
  class Update < Base
    attr_reader :params, :id, :blog

    def initialize(id, params)
      super()
      @id = id
      @params = params
    end

    def call
      return failure_response(message, errors) unless set_blog

      return failure_response(message, errors) unless update_blog

      set_data
      success_response(message, data)
    end

    private

    def set_blog
      @blog = Blog.find_by(id: @id)
      unless blog
        @message = I18n.t('model.found.failure', model_name: 'Blog')
        return false
      end
      true
    end

    def update_blog
      unless blog.update(blog_params)
        @message = I18n.t('model.update.failure', model_name: 'Blog')
        @errors = blog.errors.full_messages
        return false
      end
      true
    end

    def set_data
      @message = I18n.t('model.update.success', model_name: 'Blog')
      @data = BlogSerializer.new(blog)
    end

    def blog_params
      params.permit(:title, :content, :category)
    end
  end
end
