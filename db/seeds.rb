# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@test.com',
  password: 'password'
)

genres = Genre.create!(
  [
    {name: "Rock"},
    {name: "Pop"},
    {name: "Hip Hop"},
    {name: "Metal"},
    {name: "Acoustic"},
    {name: "高校生バンド"}
  ]
)

artist_users = ArtistUser.create!(
  [
    {email: 'dodona@test.com', password: 'password', artist_name: 'DODONA', genre_id: genres[2].id, rep_name: '土井啓太', rep_name_kana: 'ドイケイタ', introduction: 'DODONAです。Rapperやってます。', youtube_url: 'https://youtu.be/w2iPKMP2a-U', activity_location: 3, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user1.jpg"), filename:"sample_artist_user1.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header1.jpg"), filename:"sample_artist_header1.jpg")},
    {email: 'poppop@test.com', password: 'password', artist_name: 'Poppop', genre_id: genres[1].id, rep_name: '佐藤春子', rep_name_kana: 'サトウハルコ', introduction: 'Poppopです！Popな音楽を皆さんにお届けします！', activity_location: 26, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user2.jpg"), filename:"sample_artist_user2.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header2.jpg"), filename:"sample_artist_header2.jpg")},
    {email: 'juice@test.com', password: 'password', artist_name: 'Juice', genre_id: genres[0].id, rep_name: '清川隆二', rep_name_kana: 'キヨカワリュウジ', introduction: 'JuiceというRockバンドで活動しています。', activity_location: 33, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user3.jpg"), filename:"sample_artist_user3.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header3.jpg"), filename:"sample_artist_header3.jpg")},
    {email: 'eren@test.com', password: 'password', artist_name: 'EREN', genre_id: genres[2].id, rep_name: '中村樹', rep_name_kana: 'ナカムラタツキ', introduction: 'ERENです。イベント出演依頼等はDMからお願いします。', activity_location: 12, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user4.jpg"), filename:"sample_artist_user4.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header4.jpg"), filename:"sample_artist_header4.jpg")},
    {email: 'falling@test.com', password: 'password', artist_name: 'Falling', genre_id: genres[0].id, rep_name: '吉崎賢', rep_name_kana: 'ヨシザキケン', introduction: '平均年齢20歳 メンバー５人で活動中', activity_location:12 , profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user7.jpg"), filename:"sample_artist_user7.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header7.jpg"), filename:"sample_artist_header7.jpg")},
    {email: 'chimaira@test.com', password: 'password', artist_name: 'chimaira', genre_id: genres[3].id, rep_name: '小林良介', rep_name_kana: 'コバヤシリョウスケ', introduction: '2018年に５人のメンバーで結成。
    現在はサポートドラムを迎え活動中。', activity_location:12 , profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user6.jpg"), filename:"sample_artist_user6.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header6.jpg"), filename:"sample_artist_header6.jpg")},
    {email: 'diva@test.com', password: 'password', artist_name: 'Diva', genre_id: genres[5].id, rep_name: '立花夏帆', rep_name_kana: 'タチバナカホ', introduction: '全メンバー高校生！オリジナル曲を作成してLive活動中！', activity_location:23 , profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user9.jpg"), filename:"sample_artist_user9.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header9.jpg"), filename:"sample_artist_header9.jpg")},
    {email: 'dystopia@test.com', password: 'password', artist_name: 'Dystopia', genre_id: genres[2].id, rep_name: '佐藤龍馬', rep_name_kana: 'サトウリョウマ', introduction: 'Rapper トラックメイカーとしても活動中', activity_location:46 , profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user5.jpg"), filename:"sample_artist_user5.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header5.jpg"), filename:"sample_artist_header5.jpg")},
    {email: 'enigma@test.com', password: 'password', artist_name: 'Enigma', genre_id: genres[0].id, rep_name: '若菜秀行', rep_name_kana: 'ワカナヒデユキ', introduction: '５人のメンバーで活動中', activity_location:33 , profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_user8.jpg"), filename:"sample_artist_user8.jpg"), header_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_artist_header8.jpg"), filename:"sample_artist_header8.jpg")}
  ]
)

public_users = PublicUser.create!(
  [
    {email: 'komatsu@test.com', password: 'password', last_name: '小松', last_name_kana: 'コマツ', first_name: '徹', first_name_kana: 'トオル', nickname: 'KomaT', introduction: 'ロックな音楽が好きです！', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_public_user1.jpg"), filename:"sample_public_user1.jpg")},
    {email: 'ogawa@test.com', password: 'password', last_name: '小川', last_name_kana: 'オガワ', first_name: '拓海', first_name_kana: 'タクミ', nickname: 'オガッチ', introduction: '最近はJazzも聞いています！', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_public_user2.jpg"), filename:"sample_public_user2.jpg")},
    {email: 'maeda@test.com', password: 'password', last_name: '前田', last_name_kana: 'マエダ', first_name: '美緒', first_name_kana: 'ミオ', nickname: 'Maemio', introduction: '関東方面でイベンターをしています！', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_public_user3.jpg"), filename:"sample_public_user3.jpg")}
  ]
)

tags = Tag.create!(
  [
    {name: 'MV公開'},
    {name: 'Live'},
    {name: '大阪'},
    {name: '新曲'},
    {name: 'お知らせ'},
    {name: '最高'},
    {name: '質問'},
    {name: 'Feat'},
    {name: 'Metal'},
    {name: 'レコーディング'},
    {name: '音源'},
    {name: '渋谷'},
    {name: 'Rap'}
  ]
)

topics = Topic.create!(
  [
    {artist_user_id: artist_users[0].id, body: '新しいMVを近々公開します！お楽しみに！'},
    {artist_user_id: artist_users[1].id, body: '大阪でのLive最高でした！', topic_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_topic_image1.jpg"), filename:"sample_topic_image1.jpg")},
    {artist_user_id: artist_users[2].id, body: '新曲ができました！', youtube_url: 'https://youtu.be/R-rmMlon-Ww'},
    {artist_user_id: artist_users[0].id, body: '異なるジャンルの音楽を集めたイベントをやるとしたら皆さん的にはどうですか？'},
    {artist_user_id: artist_users[3].id, body: 'ERENです。この前の渋谷でのLive最高でした。また遊びましょう。'},
    {artist_user_id: artist_users[1].id, body: 'どうもPoppopです！私達主催のLiveイベントを企画しました！
    詳細は追って報告しますので。是非チェックお願いします！'},
    {artist_user_id: artist_users[4].id, body: 'Falling / Hi feat. Enigma【Official Visualizer】', youtube_url: 'https://youtu.be/r8GuIF9f_HM'},
    {artist_user_id: artist_users[8].id, body: 'Fallingさんの曲にfeatさせていただきました！
    とてもカッコいい楽曲となっていますので是非聞いて見てください！'},
    {artist_user_id: artist_users[5].id, body: 'Metalは最高です。', topic_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_topic_image2.jpg"), filename:"sample_topic_image2.jpg")},
    {artist_user_id: artist_users[2].id, body: 'この前公開した新曲が好評でとても嬉しいです！
    皆さんに、またいい音楽を届けられるように頑張りたいと思います'},
    {artist_user_id: artist_users[6].id, body: 'どうも！Divaです！
    新しい音源作りました！ジャケットはこんな感じです！
    頑張ってレコーディングしたので、みなさんに是非きいてもらいたいです！', topic_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_topic_image3.jpg"), filename:"sample_topic_image3.jpg")},
    {artist_user_id: artist_users[7].id, body: 'Dystopia / eldorado', topic_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_topic_image4.jpg"), filename:"sample_topic_image4.jpg")}
  ]
)

TopicTag.create!(
  [
    {topic_id: topics[0].id, tag_id: tags[0].id},
    {topic_id: topics[0].id, tag_id: tags[4].id},
    {topic_id: topics[0].id, tag_id: tags[3].id},
    {topic_id: topics[1].id, tag_id: tags[1].id},
    {topic_id: topics[1].id, tag_id: tags[2].id},
    {topic_id: topics[1].id, tag_id: tags[5].id},
    {topic_id: topics[2].id, tag_id: tags[3].id},
    {topic_id: topics[2].id, tag_id: tags[4].id},
    {topic_id: topics[3].id, tag_id: tags[6].id},
    {topic_id: topics[4].id, tag_id: tags[1].id},
    {topic_id: topics[4].id, tag_id: tags[5].id},
    {topic_id: topics[4].id, tag_id: tags[11].id},
    {topic_id: topics[5].id, tag_id: tags[1].id},
    {topic_id: topics[5].id, tag_id: tags[4].id},
    {topic_id: topics[6].id, tag_id: tags[0].id},
    {topic_id: topics[6].id, tag_id: tags[3].id},
    {topic_id: topics[6].id, tag_id: tags[7].id},
    {topic_id: topics[7].id, tag_id: tags[4].id},
    {topic_id: topics[7].id, tag_id: tags[7].id},
    {topic_id: topics[8].id, tag_id: tags[5].id},
    {topic_id: topics[10].id, tag_id: tags[4].id},
    {topic_id: topics[10].id, tag_id: tags[9].id},
    {topic_id: topics[10].id, tag_id: tags[10].id},
    {topic_id: topics[11].id, tag_id: tags[10].id}
  ]
)

TopicComment.create!(
  [
    {topic_id: topics[0].id, public_user_id: public_users[0].id, comment: 'とても楽しみにしています！'},
    {topic_id: topics[0].id, artist_user_id: artist_users[0].id, comment: 'コメントありがとうございます！Liveにも是非遊びに来てください！'},
    {topic_id: topics[1].id, public_user_id: public_users[1].id, comment: '大阪に行きたかったです。。'},
    {topic_id: topics[1].id, artist_user_id: artist_users[2].id, comment: 'また対バンするときはよろしくお願い致します！'},
    {topic_id: topics[2].id, public_user_id: public_users[1].id, comment: '新曲は次のLiveでやりますか？'},
    {topic_id: topics[2].id, public_user_id: public_users[2].id, comment: 'またLiveに遊びにいかせてもらいます！'},
    {topic_id: topics[2].id, artist_user_id: artist_users[1].id, comment: '楽しみです。。。！'},
    {topic_id: topics[2].id, artist_user_id: artist_users[2].id, comment: 'コメントありがとうございます！次のLiveで公開します！楽しみにしていてください！'},
    {topic_id: topics[3].id, artist_user_id: artist_users[6].id, comment: 'とてもいいと思います！'},
    {topic_id: topics[3].id, artist_user_id: artist_users[0].id, comment: 'ですよね！'},
    {topic_id: topics[8].id, public_user_id: public_users[1].id, comment: '最高です！'},
    {topic_id: topics[11].id, artist_user_id: artist_users[5].id, comment: 'カッコいいです！'}
  ]
)

Favorite.create!(
  [
    {topic_id: topics[0].id, public_user_id: public_users[0].id},
    {topic_id: topics[0].id, public_user_id: public_users[1].id},
    {topic_id: topics[0].id, artist_user_id: artist_users[0].id},
    {topic_id: topics[1].id, public_user_id: public_users[0].id},
    {topic_id: topics[1].id, public_user_id: public_users[1].id},
    {topic_id: topics[1].id, public_user_id: public_users[2].id},
    {topic_id: topics[1].id, artist_user_id: artist_users[1].id},
    {topic_id: topics[1].id, artist_user_id: artist_users[2].id},
    {topic_id: topics[2].id, public_user_id: public_users[0].id},
    {topic_id: topics[2].id, public_user_id: public_users[1].id},
    {topic_id: topics[2].id, public_user_id: public_users[2].id},
    {topic_id: topics[2].id, artist_user_id: artist_users[0].id},
    {topic_id: topics[2].id, artist_user_id: artist_users[2].id},
    {topic_id: topics[3].id, artist_user_id: artist_users[6].id},
    {topic_id: topics[4].id, artist_user_id: artist_users[0].id},
    {topic_id: topics[4].id, artist_user_id: artist_users[7].id},
    {topic_id: topics[4].id, public_user_id: public_users[2].id},
    {topic_id: topics[5].id, public_user_id: public_users[1].id},
    {topic_id: topics[6].id, artist_user_id: artist_users[8].id},
    {topic_id: topics[6].id, artist_user_id: artist_users[4].id},
    {topic_id: topics[6].id, public_user_id: public_users[0].id},
    {topic_id: topics[7].id, artist_user_id: artist_users[1].id},
    {topic_id: topics[7].id, artist_user_id: artist_users[3].id},
    {topic_id: topics[8].id, artist_user_id: artist_users[3].id},
    {topic_id: topics[8].id, artist_user_id: artist_users[6].id},
    {topic_id: topics[8].id, artist_user_id: artist_users[7].id},
    {topic_id: topics[8].id, public_user_id: public_users[0].id},
    {topic_id: topics[8].id, public_user_id: public_users[1].id},
    {topic_id: topics[8].id, public_user_id: public_users[2].id},
    {topic_id: topics[9].id, public_user_id: public_users[0].id},
    {topic_id: topics[9].id, artist_user_id: artist_users[8].id},
    {topic_id: topics[10].id, public_user_id: public_users[2].id},
    {topic_id: topics[10].id, artist_user_id: artist_users[4].id},
    {topic_id: topics[11].id, public_user_id: public_users[2].id},
    {topic_id: topics[11].id, artist_user_id: artist_users[3].id},
    {topic_id: topics[11].id, artist_user_id: artist_users[5].id}
  ]
)

# Relationship.create!(
#   [
#     {artist_follower_id: artist_users[0].id, artist_followed_id: artist_users[1].id},
#     {artist_follower_id: artist_users[0].id, public_followed_id: public_users[0].id},
#     {artist_follower_id: artist_users[1].id, artist_followed_id: artist_users[0].id},
#     {artist_follower_id: artist_users[1].id, artist_followed_id: artist_users[2].id},
#     {artist_follower_id: artist_users[2].id, artist_followed_id: artist_users[1].id},
#     {artist_follower_id: artist_users[2].id, artist_followed_id: artist_users[0].id},
#     {public_follower_id: public_users[0].id, artist_followed_id: artist_users[0].id},
#     {public_follower_id: public_users[0].id, artist_followed_id: artist_users[1].id},
#     {public_follower_id: public_users[0].id, artist_followed_id: artist_users[2].id},
#     {public_follower_id: public_users[0].id, public_followed_id: public_users[1].id},
#     {public_follower_id: public_users[1].id, artist_followed_id: artist_users[0].id},
#     {public_follower_id: public_users[1].id, artist_followed_id: artist_users[2].id},
#     {public_follower_id: public_users[1].id, public_followed_id: public_users[2].id},
#     {public_follower_id: public_users[2].id, artist_followed_id: artist_users[0].id},
#     {public_follower_id: public_users[2].id, artist_followed_id: artist_users[1].id},
#     {artist_follower_id: artist_users[5].id, artist_followed_id: artist_users[7].id},
#     {artist_follower_id: artist_users[7].id, artist_followed_id: artist_users[5].id},
#     {artist_follower_id: artist_users[3].id, artist_followed_id: artist_users[7].id},
#     {artist_follower_id: artist_users[7].id, artist_followed_id: artist_users[3].id},
#     {artist_follower_id: artist_users[4].id, artist_followed_id: artist_users[8].id},
#     {artist_follower_id: artist_users[8].id, artist_followed_id: artist_users[4].id},
#     {artist_follower_id: artist_users[6].id, artist_followed_id: artist_users[1].id},
#     {artist_follower_id: artist_users[1].id, artist_followed_id: artist_users[6].id}
#   ]
# )

rooms = Room.create!(
  [
    {name: nil},
    {name: nil},
    {name: nil},
    {name: nil},
    {name: nil}
  ]
)

Join.create!(
  [
    {room_id: rooms[0].id, artist_user_id: artist_users[0].id},
    {room_id: rooms[0].id, public_user_id: public_users[0].id},
    {room_id: rooms[1].id, artist_user_id: artist_users[0].id},
    {room_id: rooms[1].id, artist_user_id: artist_users[1].id},
    {room_id: rooms[2].id, artist_user_id: artist_users[1].id},
    {room_id: rooms[2].id, public_user_id: public_users[0].id},
    {room_id: rooms[3].id, artist_user_id: artist_users[0].id},
    {room_id: rooms[3].id, public_user_id: public_users[2].id},
    {room_id: rooms[4].id, artist_user_id: artist_users[1].id},
    {room_id: rooms[4].id, public_user_id: public_users[2].id}
  ]
)

Message.create!(
  [
    {room_id: rooms[0].id, public_user_id: public_users[0].id, content: '初めまして！DM失礼します。
    質問なのですが、新作MVの曲は既存の曲ですか？'},
    {room_id: rooms[0].id, artist_user_id: artist_users[0].id, content: 'DMありがとうございます。新作MVの曲は新曲となっております！'},
    {room_id: rooms[1].id, artist_user_id: artist_users[0].id, content: 'DM失礼します！この前のLiveは最高でした！また遊びにいかせてください！'},
    {room_id: rooms[1].id, artist_user_id: artist_users[1].id, content: 'こちらこそありがとうございます！是非是非！'},
    {room_id: rooms[2].id, public_user_id: public_users[0].id, content: '初めまして！いつも曲聞かせてもらってます！'},
    {room_id: rooms[2].id, artist_user_id: artist_users[1].id, content: '初めまして。DMありがとうございます！
    とても嬉しいです！これからもよろしくお願いします！'},
    {room_id: rooms[3].id, public_user_id: public_users[2].id, content: '初めまして！DM失礼致します。
    関東を中心にイベンターとして活動しているMaemioと申します。
    DODONAさんに私の企画しているイベントに出演してもらいたく、ご連絡させて頂きました。'},
    {room_id: rooms[3].id, artist_user_id: artist_users[0].id, content: '初めまして。DMありがとうございます！
    どのような企画なのでしょうか？'},
    {room_id: rooms[4].id, public_user_id: public_users[2].id, content: '初めまして！DM失礼致します。
    この前のLiveでPoppopさんを初めて見ることができました！とても最高でした！
    よかったら今度私の企画に出てもらうことは可能ですか？'},
    {room_id: rooms[4].id, artist_user_id: artist_users[1].id, content: '初めまして。DMありがとうございます！
    Liveに来てくださったんですね！ありがとうございます！
    私たちでよかったら是非お願いします。'}
  ]
)