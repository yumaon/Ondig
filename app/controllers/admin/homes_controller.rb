class Admin::HomesController < ApplicationController
  def top
    # 全てのArtist会員を取得
    @artist_users = ArtistUser.all

    # ジャンル設定をしていないArtist会員の取得
    @genre_nil_artsit_users = ArtistUser.where(genre_id: nil).all

    # 全ての一般会員を取得
    @public_users = PublicUser.all

    # 全てのトピックスを取得
    @topics = Topic.includes(:tags)

    # 全てのタグを取得
    @tags = Tag.all

    # 関連トピックスが無いタグの取得
    true_topics_tags = []
    @topics.each do |topic|
      # 取得した全てのtopicsを展開し、タグが存在する際には、そのtag.idをtrue_topics_tagsに格納する
      if topic.tags.present?
        topic.tags.each do |tag|
          true_topics_tags << tag.id
        end
      end
    end
    # 上記で格納したtag.idは関連トピックスが存在するので、それ以外(関連トピックス無し)のTagを取得
    @no_topics_tags = Tag.where.not(id: true_topics_tags)

    # 全てのジャンルを取得
    @genres = Genre.all

    # 設定者が０のGenreを取得するための記述
    # 全Artsit会員のgenre_idを取得し、true_artist_genresに格納
    true_artist_genres = []
    @artist_users.each do |artist|
      true_artist_genres << artist.genre_id
    end
    # 上記で格納したgenre_idは設定者が存在するので、それ以外(設定者無し)のGenreを検索し取得
    @no_artist_genres = Genre.where.not(id: true_artist_genres)

  end
end
