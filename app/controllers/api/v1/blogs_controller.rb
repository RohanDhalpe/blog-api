# frozen_string_literal: true

class Api::V1::BlogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    result = BlogService::Index.new(params).call

    if result[:success]
      render json: result.to_h, status: :ok
    else
      render json: result.to_h, status: :unprocessable_entity
    end
  end

  def create
    result = BlogService::Create.new(params).call

    if result[:success]
      render json: result.to_h, status: :ok
    else
      render json: result.to_h, status: :unprocessable_entity
    end
  end

  def update
    result = BlogService::Update.new(params[:id], params[:blog]).call

    if result[:success]
      render json: result.to_h, status: :ok
    else
      render json: result.to_h, status: :unprocessable_entity
    end
  end

  def destroy
    result = BlogService::Delete.new(params[:id]).call

    if result[:success]
      render json: result.to_h, status: :ok
    else
      render json: result.to_h, status: :unprocessable_entity
    end
  end
end
