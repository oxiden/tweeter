# -*- coding: utf-8 -*-
class MenusController < ApplicationController
  respond_to :html, :json

  def index
    unless params[:search]
      params[:search] = ActiveSupport::HashWithIndifferentAccess.new
      today = Date.today
      params[:search]["release_greater_than_or_equal_to(1i)"] = today.year
      params[:search]["release_greater_than_or_equal_to(2i)"] = today.month
      params[:search]["release_greater_than_or_equal_to(3i)"] = today.day
    end
    @search = Menu.search(params[:search])
    @menus = @search.page(params[:page])
  end
  def show
    begin
      shop = Shop.where(:id => params[:shop_id]).first || Shop.find(DEFAULT_SHOP_ID)
      @menu = shop.todays(params[:id]) # params[:id]="YYYY-MM-DD"
      @search = Menu.search(params[:search])
    rescue NoMethodError, ActiveRecord::StatementInvalid, Shop::NoMenuError
      @menu = shop.menu.build
    end
    respond_to do |format|
      format.html { @menu.persisted? ? (render :action => :show) : (redirect_to shop_menus_path(shop), alert: 'No Menu.') }
      format.json { render :json => @menu ? @menu.jsonize : @menu.to_json }
    end
  end
  def new
    @menu = Shop.find(params[:shop_id]).menu.build
    respond_to do |format|
      format.html
      format.json { render :json => @menu.to_json }
    end
  end
  def edit
    @search = Menu.search(params[:search])
    @menu = Menu.find(params[:id])
  end
  def create
    @menu = Shop.find(params[:shop_id]).menu.build(params[:menu])
    @menu.id = nil
    respond_to do |format|
      if @menu.save
        format.html { redirect_to shop_menus_path(@menu.shop), notice: 'Menu was successfully created.' }
        #format.json { render json: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        #format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    @menu = Menu.find(params[:id])
    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to shop_menus_path(@menu.shop), notice: 'Menu was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  def analysis
    shop = Shop.where(:id => params[:shop_id]).first || Shop.find(DEFAULT_SHOP_ID)
    @menus = shop.menu
    @search = Menu.search(params[:search])
  end
end
