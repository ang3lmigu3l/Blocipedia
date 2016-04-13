class ChargesController < ApplicationController
before_action :authenticate_user!
  def new
    @stripe_btn_data = {
      email: current_user.email,
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.username}",
      amount: 15_00
    }
  end

  def create
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
    customer:customer.id,
    amount: 15_00,
    description: "Blocipedia Premium Membership = #{current_user.email}",
    currency: 'usd'
    )
    flash[:notice] = "You Have Successfully Purchased a Blocipedia Premium Membership #{current_user.username} "
    redirect_to root_path

    current_user.subscribed = true
    current_user.role = 'premium'
    current_user.stripe_id = customer.id
    current_user.save

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path

  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    current_user.subscribed = false
    current_user.role = 'standard'
    current_user.save

    flash[:notice] = "You are no Longer subscribed."
    redirect_to root_path
  end

end
