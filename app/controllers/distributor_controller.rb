class DistributorController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_consent

  def index
  end
end
