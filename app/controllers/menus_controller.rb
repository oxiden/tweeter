# -*- coding: utf-8 -*-
class MenusController < ApplicationController
  respond_to :html, :json

  def index
    @search = Menu.search(params[:search])
    @menus = @search.page(params[:page])
  end
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
  def new
    @menu = Shop.find(params[:shop_id]).menu.build
    respond_to do |format|
      format.html
      format.json { render :json => @menu.to_json }
    end
  end
  def edit
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
end
