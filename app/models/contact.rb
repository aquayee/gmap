class Contact < ActiveRecord::Base
  validates_presence_of :contact_no
  validates_presence_of :kind
  belongs_to :supplier
end
