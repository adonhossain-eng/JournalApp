class AiChatController < ApplicationController
  protect_from_forgery with: :null_session

  def chat
    user_message = params[:message]
    ai_response = OllamaClient.generate_response(user_message)

    render json: { response: ai_response }
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
