class Measure < ApplicationRecord
  belongs_to :node
  belongs_to :sensor
end