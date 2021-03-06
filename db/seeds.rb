

user = User.create!(email: 'payne@payne.com', password: 'password', password_confirmation: 'password')
user2 = User.create!(email: 'payne2@payne.com', password: 'password', password_confirmation: 'password')
10.times do |n|
  password = Faker::Internet.password
  User.create!(email: Faker::Internet.email, password: password, password_confirmation: password)
end

languages = ['dutch', 'japanese', 'portuguese', 'russian', 'spanish']
languages.each_with_index do |language, idx|
  foreign_language_deck = Deck.create!(title: language.capitalize, public: true, course_id: idx, owner_id: user.id)
  File.open('./vendor/assets/languages/' + language + '.txt','r') do |foreign_text|
    File.open('./vendor/assets/languages/extracted_text.txt', 'r') do |english_text|
      question = foreign_text.gets
      answer = english_text.gets
      count = 0
      while (count < 100)
        card = Card.create(deck_id: foreign_language_deck.id, question: question, answer: answer)
        question = foreign_text.gets
        answer = english_text.gets
        count+=1
      end
    end
  end
end

10.times do |n|
  5.times { |n| Message.create!(receiver_id: user.id, sender_id: Random.rand(10), body: Faker::Lorem.paragraph) }
  5.times { |n| Message.create!(receiver_id: Random.rand(10), sender_id: user.id, body: Faker::Lorem.paragraph) }
end

10.times do |n|
  subforum = Sub.create(
    title: Faker::Name.title,
    description: Faker::Hacker.say_something_smart,
    image_url: Faker::Avatar.image,
    moderator_id: user.id
  )
  10.times do |m|
    newPost = subforum.posts.create(
      title: Faker::Name.title,
      url: Faker::Internet.url,
      content: Faker::Lorem.paragraph,
      user_id: user.id
    )
    3.times do |r|
      comment = newPost.comments.create(body: Faker::Lorem.sentence(2), user_id: user.id)
      comment2 = newPost.comments.create(body: Faker::Lorem.sentence, user_id: user2.id, parent_comment_id: comment.id)
      comment3 = newPost.comments.create(body: Faker::Lorem.sentence(3), user_id: user.id, parent_comment_id: comment2.id)
      comment4 = newPost.comments.create(body: Faker::Lorem.sentence(3), user_id: user2.id, parent_comment_id: comment3.id)
    end
  end
end
