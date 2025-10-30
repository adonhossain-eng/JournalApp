class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item, only: %i[ edit update destroy ]
    def index
        @items = current_user.items.order(created_at: :desc)
    end

    def new
        @item = Item.new()
    end

    def create
        @item = current_user.items.build(entry_params)
        if @item.save
            redirect_to root_url
        else
            render :new, status: :unprocessable_entity
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
        params.require(:item).permit(:user_id, :name, :tag, :content)
    end

    def set_item
        @item = current_user.items.find(params[:id])
    end
end
