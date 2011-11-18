class Supplier < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  #searchable do
  #  text :name, :stored => true, :default_boost => 2
  #  text :body, :stored => true
  #  text :region, :stored => true do
  #    cities = self.addresses.map { |address| address.city }
  #    regions = countries + cities
  #    #puts "regions #{regions}"
  #    regions
  #  end
  #  integer :category_id, :references => Category 
  #end

  has_many :addresses
  has_many :contacts
  belongs_to :category

  after_update :save_addresses, :save_contacts

  def index_address
    self.addresses.collect(&:addr).join(",")
  end

  def new_address_attributes=(address_attributes)
    address_attributes.each do |attributes|
      addresses.build(attributes)
    end
  end

  def new_contact_attributes=(contact_attributes)
    logger.debug "calling new contact attributes"
    contact_attributes.each do |attributes|
      contacts.build(attributes)
    end
  end

  def existing_contact_attributes=(contact_attributes)
    logger.debug "calling existing contact attributes"
    contacts.reject(&:new_record?).each do |contact|
      attributes = contact_attributes[contact.id.to_s]
      logger.debug "contact_attributes[contact.id.to_s] #{attributes}"
      if attributes
        logger.debug "update it"
        contact.attributes = attributes
      else
        logger.debug "delete it"
        contacts.delete(contact)
      end
    end
  end

  def existing_address_attributes=(address_attributes)
    addresses.reject(&:new_record?).each do |address|
      attributes = address_attributes[address.id.to_s]
      if attributes
        address.attributes = attributes
      else
        addresses.delete(address)
      end
    end
  end

  def save_contacts
    logger.debug "save contacts"
    contacts.each do |contact|
      contact.save
    end
  end
  
  def save_addresses
    addresses.each do |address|
      address.save
    end
  end

end
