class ArtistUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :genre, optional: true
  has_many :live_schedules, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :topic_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :joins, dependent: :destroy

  # followをした、followをされたの関係
  has_many :artist_relationships, class_name: "Relationship", foreign_key: "artist_follower_id", dependent: :destroy
  has_many :artist_reverse_of_relationships, class_name: "Relationship", foreign_key: "artist_followed_id", dependent: :destroy

  # followをしているかの確認時に
  has_many :artist_followings, through: :artist_relationships, source: :artist_followed
  has_many :public_followings, through: :artist_relationships, source: :public_followed
  # has_many :artist_followers, through: :artist_reverse_of_relationships, source: :artist_follower
  # has_many :public_followers, through: :artist_reverse_of_relationships, source: :public_follower

  has_one_attached :profile_image
  has_one_attached :header_image

  validates :artist_name, presence: true
  validates :rep_name, presence: true
  validates :rep_name_kana, presence: true
  validates :activity_location, presence: true

  # 退会していないユーザーを取得するための記述
  scope :active, -> { where(is_deleted: false) }

  # 退会しているユーザーを取得するための記述
  scope :deleted, -> { where(is_deleted: true) }

  # Artistの検索機能（絞り込み検索）
  scope :search, -> (search_params) do
    return if search_params.blank?

    # パラメータを指定して検索を実行する
    artist_name_like(search_params[:artist_name])
      .genre_id_is(search_params[:genre_id])
      .activity_location_is(search_params[:activity_location])
  end

  # artist_nameが存在する場合、artist_nameをlike検索する
  scope :artist_name_like, -> (artist_name) { where('artist_name LIKE ?', "%#{artist_name}") if artist_name.present? }
  # genre_idが存在する場合、genre_idで検索する
  scope :genre_id_is, -> (genre_id) { where(genre_id: genre_id) if genre_id.present? }
  # activity_locationが存在する場合、activity_locationで検索する
  scope :activity_location_is, -> (activity_location) { where(activity_location: activity_location) if activity_location.present? }

  # ゲストログイン機能のメソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |artist_user|
      artist_user.password = SecureRandom.urlsafe_base64
      artist_user.rep_name = "ゲスト"
      artist_user.rep_name_kana = "ゲスト"
      artist_user.artist_name = "ゲストユーザー"
      artist_user.activity_location = 0
    end
  end

  # followをしたときの処理
  def follow_an_artist(artist_user_id)
    artist_relationships.create(artist_followed_id: artist_user_id)
  end

  def follow_an_public(public_user_id)
    artist_relationships.create(public_followed_id: public_user_id)
  end

  # followを外すときの処理
  def unfollow_an_artist(artist_user_id)
    artist_relationships.find_by(artist_followed_id: artist_user_id).destroy
  end

  def unfollow_an_public(public_user_id)
    artist_relationships.find_by(public_followed_id: public_user_id).destroy
  end

  # followをしているか判定をする処理
  def artist_following?(artist_user)
    artist_followings.include?(artist_user)
  end

  def public_following?(public_user)
    public_followings.include?(public_user)
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile_no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  def get_header_image
    unless header_image.attached?
      file_path = Rails.root.join('app/assets/images/profile_no_header_image.jpg')
      header_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    header_image
  end

  enum activity_location: {
    hokkaido: 0, aomori: 1, iwate: 2, miyagi: 3, akita: 4, yamagata: 5, fukushima: 6, ibaraki: 7, tochigi: 8, gunma: 9, saitama: 10,
    chiba: 11, tokyo: 12, kanagawa: 13, niigata: 14, toyama: 15, ishikawa: 16, fukui: 17, yamanashi: 18, nagano: 19, gifu: 20,
    shizuoka: 21, aichi: 22, mie: 23, shiga: 24, kyoto: 25, osaka: 26, hyogo: 27, nara: 28, wakayama: 29, tottori: 30,
    shimane: 31, okayama: 32, hiroshima: 33, yamaguchi: 34, tokushima: 35, kagawa: 36, ehime: 37, kochi: 38, fukuoka: 39, saga: 40,
    nagasaki: 41, kumamoto: 42, oita: 43, miyazaki: 44, kagoshima: 45, okinawa: 46
  }

end
