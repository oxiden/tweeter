# -*- coding: utf-8 -*-
class MenusController < ApplicationController
  include ApplicationHelper

  def index
    unless params[:q]
      params[:q] = ActionController::Parameters.new
    end
    @q = Menu.ransack(params[:q].merge(params[:q]["title_cont"].to_s == "" ? {"release_gteq" => Date.today} : {}))
    @q.sorts = "release" if @q.sorts.empty?
    @menus = @q.result.page(params[:page])
  end
  def show
    begin
      shop = Shop.where(:id => params[:shop_id]).first || Shop.find(DEFAULT_SHOP_ID)
      @menu = shop.todays(params[:id]) # params[:id]="YYYY-MM-DD"
      @q = Menu.ransack(params[:q])
    rescue NoMethodError, ActiveRecord::StatementInvalid, Shop::NoMenuError
      @menu = shop.menu.build
    end
    respond_to do |format|
      format.html { @menu.persisted? ? (render :action => :show) : (redirect_to shop_menus_path(shop), alert: 'No Menu.') }
      format.json { render :json => @menu ? @menu.jsonize : @menu.to_json }
    end
  end
end
