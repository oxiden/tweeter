# -*- coding: utf-8 -*-
class Shop < ApplicationRecord
  has_many :menu

  class NoMenuError < StandardError; end

  # retrieve today's lunch menu
  def todays(date = Date.today)
    menu = self.menu.where(:release => date).first
    raise NoMenuError if menu.nil? or menu.title.blank?
    menu
  end
end
