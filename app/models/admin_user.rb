class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable 
   def admin?
    role == 'admin'
   end

  def superadmin?
    role == 'superadmin'
  end

  def hradmin?
    role == 'hradmin'
  end
  def empty?
    role == ''
  end
end
