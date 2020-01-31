# -*- coding: utf-8 -*-
class ShopsController < ApplicationController
  #respond_to :html, :json

  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result.page
  end
end
