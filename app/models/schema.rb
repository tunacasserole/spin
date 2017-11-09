UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'Somebody to lean on'

  field :id, !types.ID
  field :name, !types.String, property: :name
  field :email, !types.String, 'Like a phone number, but spammier'
  field :login, !types.String, 'Use this to log in to your computer'
end

QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The root of all queries'

  field :allUsers do
    type types[UserType]
    description 'Everyone in the Universe'
    resolve -> (obj, args, ctx) { User.all.limit(10) }
  end
  field :User do
    type UserType
    description 'The User associated with a given ID'
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { User.find(args[:id]) }
  end
end
Schema = GraphQL::Schema.define do
  query QueryType
end
