module ApplicationHelper
  def fields_for_address(address, &block)
    prefix = address.new_record? ? 'new' : 'existing'
    fields_for("supplier[#{prefix}_address_attributes][]", address, &block)
  end
  def fields_for_contact(contact, &block)
    prefix = contact.new_record? ? 'new' : 'existing'
    fields_for("supplier[#{prefix}_contact_attributes][]", contact, &block)
  end

  def gmap_maker_locations(search)
    locations = []
    @search.each_hit_with_result do |hit, supplier|
      address = supplier.addresses.first if not supplier.addresses.blank?
      next if address.nil?
      next if address.lat.blank? or address.lng.blank?
      locations << "[\"#{supplier.name}\",#{address.lat},#{address.lng},\"http://#{request.host}#{supplier_path(supplier)}\",\"#{address.addr}\"]"
    end 
    locations
  end

  def gmap_marker_locations_js_var(search)
    gmap_maker_locations(search).join(",")
  end
end
