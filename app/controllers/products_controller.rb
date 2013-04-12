class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  before_filter :products_array

  def products_array
    @products = Product.all.to_a
  end

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @id = params[:id]
    p = Product.new
    @product = Product.find(@id)
    @review = Review.new
    @product_reviews = Review.where(:product_id => @id)
    @list = p.google(@product.name)
    @picture = @list['items'][0]['product']['images'][0]['link']
    @link = @list['items'][0]['product']['link']
    @description = @list['items'][0]['product']['description']
    # @total = @products.map{|sum, n| sum + n }
    @average = @product_reviews.average('rating')


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    @list = @product.google(@product.name)
    @picture = @list['items'][0]['product']['images'][0]['link']
    @link = @list['items'][0]['product']['link']
    @description = @list['items'][0]['product']['description']
    @product.image_url = @picture

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
