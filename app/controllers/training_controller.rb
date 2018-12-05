class TrainingController < ApplicationController
  def show
    @current_training = current_user.pending_training
  end
end

