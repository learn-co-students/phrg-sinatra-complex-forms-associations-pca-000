# frozen_string_literal: true

class Pet < ActiveRecord::Base
  belongs_to :owner
end
