class MessagesController < ApplicationController

  before_action :authenticate_user!
  load_resource only: [:update, :destroy]
  authorize_resource

  # GET /messages. Yoink all messages received by the current user.
  def index
    render json: current_user.received_messages
  end

  # POST /messages. Create a new message: author (messager): current user;
  # recipient (messagee): to be supplied.
  def create
    message = Message.new(message_params)
    message.messager = current_user

    if message.valid?
      message.save!
      render json: message
    else
      render json: message.errors, status: 422
    end
  end

  def update
    @message.update! message_params

    if @message.valid?
      render json: @message
    else
      render json: @message.errors, status: 422
    end
  end

  def destroy
    @message.destroy

    render json: @message
  end

  private

  def message_params
    params.require(:message).permit(:messagee_id, :content, :seen_at)
  end

end