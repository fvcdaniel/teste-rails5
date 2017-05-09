module UsersHelper
  
  def inscritos
    return User.scoped.subscribed.where("invited_by = "+current_user.id.to_s).to_a
  end
  def subscriber(email)
    return User.find(User.scoped.subscribed.where("email = '"+email+"'").first.invited_by)
  end
  
end
