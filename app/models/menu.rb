# -*- coding: utf-8 -*-
class Menu < ApplicationRecord
  belongs_to :shop

  def カレー?
    !!(self.title =~ /カレー/)
  end
  def jsonize
    ActiveSupport::JSON.decode(self.to_json).merge(:curry => self.カレー?).to_json
  end
end
