return if User.count > 0

require 'csv'
path =  Rails.root.join('db', 'post_seeds.csv')
csv = CSV.read(path, { headers: true })


first_user = User.new( 
  name: "テストユーザー",
  email: "test@example.com",
  description: "テストユーザーです",
  password: 'password',
  password_confirmation: 'password')

if first_user.save
  first_post = first_user.phrases.create(
    title: "配られたカードで勝負するっきゃないのさ", 
    author: "スナフキン", 
    tag_list: "スヌーピー")
  first_user.likes.create(phrase_id: first_post.id)

  12.times do |n|
    row = csv[n]
    post = first_user.phrases.create(
      title: row["title"],
      author: row["author"],
      quoted: row["quoted"],
      tag_list: row["tag_list"]
    )
  end 
end

(csv.length - 12).times do |n|
  user = User.create(name: "#{Faker::Name.name}",
    email: "test#{n}@example.com",
    description: "#{n}番目のsampleアカウントです",
    password: 'password',
    password_confirmation: 'password')

  row = csv[n + 12]
  post = user.phrases.create(
    title: row["title"],
    author: row["author"],
    quoted: row["quoted"],
    tag_list: row["tag_list"]
  )
  first_user.likes.create(phrase_id: post.id)
  user.likes.create(phrase_id: first_post.id)

end
