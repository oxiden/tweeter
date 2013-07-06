# -*- coding: utf-8 -*-
class Menu < ActiveRecord::Base
  attr_accessible :release, :title, :memo
  belongs_to :shop
  default_scope order(Menu.arel_table[:release].desc)

  def カレー?
    !!(self.title =~ /カレー/)
  end
  def jsonize
    ActiveSupport::JSON.decode(self.to_json).merge(:curry => self.カレー?).to_json
  end
end
