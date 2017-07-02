Warden::Manager.after_set_user do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
  # when the application is run this method will
  # assign the user's is to the cookie specified above
  # making it available to action cable
end

Warden::Manager.before_logout do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = nil
  # when the user logs out, the cookie will be set to nil
end