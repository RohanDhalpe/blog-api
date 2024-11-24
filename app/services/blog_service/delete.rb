# frozen_string_literal: true

module BlogService
  class Delete < Base
    attr_reader :id, :blog

    def initialize(id)
      super()
      @id = id
    end

    def call
      return failure_response(message, errors) unless set_blog

      return failure_response(message, errors) unless delete_blog

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

    def delete_blog
      unless blog.destroy
        @message = I18n.t('model.delete.failure', model_name: 'Blog')
        @errors = blog.errors.full_messages
        return false
      end
      true
    end

    def set_data
      @message = I18n.t('model.delete.success', model_name: 'Blog')
      @data = { id: @id }
    end
  end
end
