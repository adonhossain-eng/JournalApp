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

    def destroy
        Item.find(params[:id]).destroy
        redirect_to root_url
    end

    private

    def entry_params
        params.require(:item).permit(:name, :link)
    end

end
