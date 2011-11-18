class AddressesController < ApplicationController
  def new_address_field
    @supplier = Supplier.new 
    @supplier.addresses.build
    @supplier.phones.build
  end
  # GET /addresses
  # GET /addresses.xml
  def index
    @addresses = Address.all
    #@map = Cartographer::Gmap.new( 'map' )
    #@map.zoom = :bound
    #@icon = Cartographer::Gicon.new()
    #@map.icons <<  @icon
    #marker1 = Cartographer::Gmarker.new(:name=> "taj_mahal", :marker_type => "Building",
    #           :position => [27.173006,78.042086],
    #           :info_window_url => "/url_for_info_content", :icon => @icon)
    #marker2 = Cartographer::Gmarker.new(:name=> "raj_bhawan", :marker_type => "Building",
    #           :position => [28.614309,77.201353],
    #           :info_window_url => "/url_for_info_content", :icon => @icon)
    #
    #@map.markers << marker1
    #@map.markers << marker2
    @map = initialize_map

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @addresses }
    end

  end

  private
  def initialize_map
     @map = Cartographer::Gmap.new( 'map' )
     @map.controls << :type
     @map.controls << :large
     @map.controls << :scale
     @map.controls << :overview
     @map.debug = false
     @map.marker_mgr = false
     @map.marker_clusterer = true

     cluster_icons = []
     org = Cartographer::ClusterIcon.new({:marker_type => "Organization"})
      org << {
                  :url => '/images/drop.gif',
                  :height => 73,
                   :width => 118,
                  :opt_anchor => [10, 0],
                  :opt_textColor => 'black'
                }
      org << {
                  :url => '/images/drop.gif',
                  :height => 73,
                  :width => 118,
                  :opt_anchor => [20, 0],
                  :opt_textColor => 'black'
                }

       org << {
                  :url => '/images/drop.gif',
                  :height => 73,
                  :width => 118,
                  :opt_anchor => [26, 0],
                  :opt_textColor => 'black'
              }
      cluster_icons << org



      @map.marker_clusterer_icons = cluster_icons



     return @map
   end


  # GET /addresses/1
  # GET /addresses/1.xml
  def show
    @address = Address.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.xml
  def new
    @address = Address.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    @address = Address.find(params[:id])
  end

  # POST /addresses
  # POST /addresses.xml
  def create
    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save
        format.html { redirect_to(@address, :notice => 'Address was successfully created.') }
        format.xml  { render :xml => @address, :status => :created, :location => @address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.xml
  def update
    @address = Address.find(params[:id])

    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to(@address, :notice => 'Address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.xml
  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    respond_to do |format|
      format.html { redirect_to(addresses_url) }
      format.xml  { head :ok }
    end
  end
end
