# -*- coding: utf-8 -*-
class MenusController < ApplicationController
  def show
    begin
      shop = Shop.where(:id => params[:shop_id]).first
      @menu = shop.todays(params[:id])
    rescue NoMethodError, ActiveRecord::StatementInvalid, Shop::NoMenuError
      @menu = nil
    end
    respond_to do |format|
      format.html
      format.json { render :json => @menu ? @menu.jsonize : @menu.to_json }
    end
  end
end
