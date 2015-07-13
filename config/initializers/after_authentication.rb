Warden::Manager.after_authentication do |user, auth, opts|
  auth.cookies.signed[:user_id] = user.id
end
