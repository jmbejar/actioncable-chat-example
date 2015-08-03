module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      ActiveRecord::Base.connection_pool.with_connection do |conn|
        if current_user = User.find(cookies.signed[:user_id])
          current_user
        else
          reject_unauthorized_connection
        end
      end
    end
  end
end
