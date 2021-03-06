require_relative '../data_mapper_setup'
require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id,       Serial
  property :email,    String, required: true, unique: true, format: :email_address
  property :name,     String, required: true
  property :username, String, required: true, unique: true
  property :password, BCryptHash
  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password

  has n, :peeps

  def self.authenticate(email, password, encryption_class = BCrypt::Password)
    user = first(email: email)
    user && encryption_class.new(user.password) == password ? user : nil
  end

end
