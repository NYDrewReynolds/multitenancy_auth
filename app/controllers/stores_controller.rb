class StoresController < ApplicationController
  before_action :load_store, only: [:edit, :show]
  before_action :require_login, only: [:edit]
  before_action :authorize!, only: [:edit]

  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end

  def edit
  end

  private

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  def authorize!
    unless Permission.new(current_user).can_edit_store?(@store)
      flash[:notice] = "Can't let you do that, #{current_user.name}!"
      redirect_to root_path
    end
  end

  def load_store
    @store = Store.find(params[:id])
  end
end
