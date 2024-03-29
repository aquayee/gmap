class SuppliersController < ApplicationController
  
  def suggestion
    @suggestions = []
    @search = Supplier.search do
      keywords(params[:q]) do
        #highlight :name
        highlight :region
      end
      paginate :page => 1, :per_page => 100
    end
    @search.each_hit_with_result do  |hit, supplier|
      @suggestions.push(supplier.name) 
      @suggestions.push(hit.stored(:region).first) if hit.highlight(:region)
    end
    render :text => @suggestions.uniq.join("\n")
  end

  def search
    @search = Supplier.search do
      keywords(params[:q]) do
        highlight :body
      end
      paginate(:page => params[:page])
      facet :category_id
    end
  end

  # GET /suppliers
  # GET /suppliers.xml
  def index
    @suppliers = Supplier.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @suppliers }
    end
  end

  # GET /suppliers/1
  # GET /suppliers/1.xml
  def show
    @supplier = Supplier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @supplier }
    end
  end

  # GET /suppliers/new
  # GET /suppliers/new.xml
  def new
    @supplier = Supplier.new
    1.times { @supplier.addresses.build }
    1.times { @supplier.contacts.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @supplier }
    end
  end

  # GET /suppliers/1/edit
  def edit
    @supplier = Supplier.find(params[:id])
    #@supplier.addresses.build
    #@supplier.contacts.build
  end

  # POST /suppliers
  # POST /suppliers.xml
  def create
    @supplier = Supplier.new(params[:supplier])

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to(@supplier, :notice => 'Supplier was successfully created.') }
        format.xml  { render :xml => @supplier, :status => :created, :location => @supplier }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /suppliers/1
  # PUT /suppliers/1.xml
  def update
    params[:supplier][:existing_address_attributes] ||= {}
    params[:supplier][:existing_contact_attributes] ||= {}
    @supplier = Supplier.find(params[:id])

    respond_to do |format|
      if @supplier.update_attributes(params[:supplier])
        format.html { redirect_to(@supplier, :notice => 'Supplier was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @supplier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.xml
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to(suppliers_url) }
      format.xml  { head :ok }
    end
  end
end
