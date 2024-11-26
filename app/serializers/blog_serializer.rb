# frozen_string_literal: true

class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :category, :user_id
end
