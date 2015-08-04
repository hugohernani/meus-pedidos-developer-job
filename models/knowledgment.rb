class Knowledgement
  include DataMapper::Resource

  property :id, Serial
  property :language, String
  property :level, Integer

  property :created_at, DateTime
  property :updated_at, DateTime

end

class UserKnowledgement
  include DataMapper::Resource

  property :id, Serial

  has 1, :user
  has n, :knowledgements
end
