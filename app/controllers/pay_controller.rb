class PayController < ApplicationController

  def index
  end

  def update_dd_info
    msg = false
    pay = Pay.new(
    :bank_account_num => params[:bank_account_num],
    :bank_routing_num => params[:bank_routing_num],
    :percent_of_deposit => params[:dd_percent],
    :show_secure_token => !!params[:show_secure_token]
    )
    pay.user_id = current_user.user_id
    msg = true if pay.save!
    respond_to do |format|
      format.json {render :json => {:msg => msg } }
    end
  end

  def show
   respond_to do |format|
     return_val = current_user.pay.as_json
     return_val.each do |pay_json|
      pay_json["bank_routing_num"] = "CTF[NSAMostWanted]" if pay_json["show_secure_token"]
     end
     format.json { render :json => {:user => return_val} }
   end
  end

  def destroy
    pay = Pay.find_by_id(params[:id])
    if pay.present? and pay.destroy
      flash[:success] = "Successfully Deleted Entry"
    else
      flash[:error] = "Unable to process that request at this time"
    end
    redirect_to user_pay_index_path
  end

  def decrypted_bank_acct_num
    decrypted = Encryption.decrypt_sensitive_value(params[:value_to_decrypt])
    respond_to do |format|
      format.json {render :json => {:account_num => decrypted || "No Data" }}
    end
  end
end
