class PublicUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :topic_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :joins, dependent: :destroy

  # followをした、followをされたの関係
  has_many :public_relationships, class_name: "Relationship", foreign_key: "public_follower_id", dependent: :destroy
  has_many :public_reverse_of_relationships, class_name: "Relationship", foreign_key: "public_followed_id", dependent: :destroy

  # followをしているかの確認時に使用。
  has_many :artist_followings, through: :public_relationships, source: :artist_followed
  has_many :public_followings, through: :public_relationships, source: :public_followed
  # has_many :public_followers, through: :public_reverse_of_relationships, source: :public_follower

  has_one_attached :profile_image

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true


  # 退会していないユーザーを取得するための記述
  scope :active, -> { where(is_deleted: false) }

  # 退会しているユーザーを取得するための記述
  scope :deleted, -> { where(is_deleted: true) }

  # ゲストログイン機能のメソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |public_user|
      public_user.password = SecureRandom.urlsafe_base64
      public_user.last_name = "ゲスト"
      public_user.first_name = "ゲスト"
      public_user.last_name_kana = "ゲスト"
      public_user.first_name_kana = "ゲスト"
      public_user.nickname = "ゲストユーザー"
    end
  end

  # followをしたときの処理
  def follow_an_artist(artist_user_id)
    public_relationships.create(artist_followed_id: artist_user_id)
  end

  def follow_an_public(public_user_id)
    public_relationships.create(public_followed_id: public_user_id)
  end

  # followを外すときの処理
  def unfollow_an_artist(artist_user_id)
    public_relationships.find_by(artist_followed_id: artist_user_id).destroy
  end

  def unfollow_an_public(public_user_id)
    public_relationships.find_by(public_followed_id: public_user_id).destroy
  end

  # followをしているか判定をする処理
  def artist_following?(artist_user)
    artist_followings.include?(artist_user)
  end

  def public_following?(public_user)
    public_followings.include?(public_user)
  end

  # キーワード検索の処理(苗字、氏名、ニックネームで検索できるよう記述)
  def self.search(keyword)
    PublicUser.where(["last_name LIKE? OR first_name LIKE? OR nickname LIKE?","%#{keyword}","%#{keyword}","%#{keyword}"])
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/profile_no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  def name_display
    last_name + first_name
  end
end
