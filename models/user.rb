class User
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :required => true
  property :email, String, :required => true, :unique => true,
    :format => :email_address,
    :messages => {
      :presence  => "Email address is required",
      :is_unique => "This email address already exists.",
      :format    => "It doesn't look like a email address."
    }

  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :user_knowledgements, :child_key => [:knowledgements]
end
