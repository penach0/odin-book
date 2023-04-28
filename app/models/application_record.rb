class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def type
    self.class.to_s
  end
end
