class ItemsController < ApplicationController
    def index
        @items = Item.all
    end

    def new
        @item = Item.new()
    end

    def create
        @item = Item.new(entry_params)
        if @item.save
            redirect_to root_url
        else
            render :new
        end
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        if @item.update(entry_params)
            redirect_to root_url
        else
            render :edit
        end
    end

    def destroy
        Item.find(params[:id]).destroy
        redirect_to root_url
    end

    private

    def entry_params
        params.require(:item).permit(:name, :tag, :content)
    end
end
