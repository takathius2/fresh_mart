class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    add_flash_types :success, :info, :warning, :danger
    def after_sign_in_path_for(resource)
        "/"
    end
    
    def after_sign_out_path_for(resource)
        "/"
    end
    
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [
            :password, :last_name, :first_name, :last_name_kana, :first_name_kana, 
            :telephone_number, :postal_code, :address])
    end
        
end
