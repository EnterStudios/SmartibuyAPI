configure :development, :test do
  ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
end

configure :production do
  # Use Heroku's parameters stored in their DATABASE_URL environment variable
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

  ActiveRecord::Base.establish_connection(
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  )
end
