# -*- coding: utf-8 -*-
class ShopsController < ApplicationController
  #respond_to :html, :json

  def index
    @search = Shop.search(params[:search])
    @shops = @search.paginate(:page => params[:page], :per_page => 20)
  end
  def show
    begin
      @shop = Shop.where(:id => params[:id]).first
    rescue ActiveRecord::StatementInvalid
      @shop = nil
    end
    respond_to do |format|
      format.html
      #format.json { render :json => @shop ? @shop.jsonize : @shop.to_json }
    end
  end
end
