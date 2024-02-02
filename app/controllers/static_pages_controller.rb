class StaticPagesController < ApplicationController
  # skip_verify_authorized only: %i[about_us cookie_policy donate faq partners privacy_policy terms_and_conditions]

  def home
    if !current_tenant
      render :no_tenant and return
    end
  end

  def account_select
  end

  def about_us
  end

  def faq
  end

  def partners
  end

  def donate
  end

  def privacy_policy
  end

  def terms_and_conditions
  end

  def cookie_policy
  end
end
