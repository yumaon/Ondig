class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    # 関連トピックス無しのタグ一覧を表示させる場合
    if params[:topics_nil].present?
      # 全てのTopicsを取得し一つずつ展開しタグが存在するか調べる
      topics = Topic.includes(:tags)
      true_topics_tags = []
      topics.each do |topic|
        # Topicsにタグが存在する場合に、そのtag.idをtrue_topics_tagsに格納する
        if topic.tags.present?
          topic.tags.each do |tag|
            true_topics_tags << tag.id
          end
        end
      end
      # 上記で格納したtag.idは関連Topicsが存在するので、それ以外(関連Topics無し)のTagを取得
      @tags = Tag.where.not(id: true_topics_tags).page(params[:page]).per(20)
    else

      # 全てのタグを表示させる場合
      @tags = Tag.all.page(params[:page]).per(20)
    end
  end

  # タグ情報を削除
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end
end
