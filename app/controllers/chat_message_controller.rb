class ChatMessageController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @item = Item.find(params[:item_id])
    @chat_messages = ChatMessage.where(items_id: @item.id).order(:time_sent)
    render json: @chat_messages
  end

  def create
    @chat_message = ChatMessage.new(chat_message_params)
    if @chat_message.save
      render json: { status: "success", message: @chat_message }, status: :created
    else
      render json: { status: "error", errors: @chat_message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:items_id, :sender, :content)
  end
end
