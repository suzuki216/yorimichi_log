# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: "l@admin") do |admin|
  admin.password = "121212"
end

User.find_or_create_by!(email: "test1@test") do |user|
  user.last_name = "山田"
  user.first_name = "太郎"
  user.password = "121212"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user2.jpeg"), filename: "sample_user2.jpeg")
end

User.find_or_create_by!(email: "test2@test") do |user|
  user.last_name = "佐々木"
  user.first_name = "二郎"
  user.password = "131313"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user3.png"), filename: "sample_user3.png")
end


User.find_or_create_by!(email: "test3@test") do |user|
  user.last_name = "山田"
  user.first_name = "花子"
  user.password = "141414"
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_user1.jpg"), filename: "sample_user1.jpg")
end

Post.find_or_create_by!(title: "山長街の日の出") do |post|
  post.body = "山長街の山長公園の頂上から見た朝焼け風景になります。山長街の中心街に行けばたくさんの商店があります。"
  post.category_name = "街"
  post.user = User.find_by(email: "test1@test")
  post.images.attach(
    io: File.open("#{Rails.root}/db/fixtures/dew.jpg"),
    filename: "dew.jpg"
  )
end

Post.find_or_create_by!(title: "町永町のとある路地裏") do |post|
  post.body = "町永県町永町のUNIX展の裏にある路地裏です。知られてない素敵なお店がありますので、ぜひ足をはこんでみてください!"
  post.category_name = "町"
  post.user = User.find_by(email: "test2@test") 
  post.images.attach(
    io: File.open("#{Rails.root}/db/fixtures/alley.jpg"),
    filename: "alley.jpg"
  )
end

Post.find_or_create_by!(title: "おすすめしたい海での散歩道！") do |post|
  post.body = "海浜町にある私がおすすめしたい場所です。綺麗な砂浜、道、海と心が癒されると思いますので、息抜きでぜひ寄ってみてください。"
  post.category_name = "海"
  post.user = User.find_by(email: "test3@test")
  post.images.attach(
    io: File.open("#{Rails.root}/db/fixtures/seaside.jpg"),
    filename: "seaside.jpg"
  )
end
