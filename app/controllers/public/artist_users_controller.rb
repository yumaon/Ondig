class Public::ArtistUsersController < ApplicationController
  # アーティスト一覧画面
  def index
    @genres = Genre.all
    @public_user = current_public_user
    @search_params = artist_user_search_params

    # サイドバーのジャンル検索ボタンを押された時の処理
    if params[:name].present?
      # 指定されたジャンルに紐づいている、退会していないArtistUserを取得
      @artist_users = Genre.find(params[:name]).artist_users.active.order(created_at: :desc).page(params[:page]).per(9)
    else
      # 退会していないArtistUserを取得
      @artist_users = ArtistUser.active.order(created_at: :desc).page(params[:page]).per(9)
    end
  end

   # Artist検索アクション
  def search
    @public_user = current_public_user
    @genres = Genre.all
    @search_params = artist_user_search_params
    # 最新順でArtistUserを表示させる場合
    if params[:display_select] == "1"
      @artist_users = ArtistUser.active.search(@search_params).includes(:genre).order(created_at: :desc).page(params[:page]).per(9)
    # 登録日順でArtistUserを表示させる場合
    elsif params[:display_select] == "2"
      @artist_users = ArtistUser.active.search(@search_params).includes(:genre).page(params[:page]).per(9)
    # フォロワーが多い順でArtistUserを表示させる場合
    elsif params[:display_select] == "3"
      @artist_users = Kaminari.paginate_array(ArtistUser.active.search(@search_params).includes(:genre).sort {|a, b| b.active_followers.count.to_i <=> a.active_followers.count.to_i}).page(params[:page]).per(9)
    # フォロワーが少ない順でArtistUserを表示させる場合
    elsif params[:display_select] == "4"
      @artist_users = Kaminari.paginate_array(ArtistUser.active.search(@search_params).includes(:genre).sort {|a, b| a.active_followers.count.to_i <=> b.active_followers.count.to_i}).page(params[:page]).per(9)
    end
    render "index"
  end

  private
  # ストロングパラメータ
  def artist_user_search_params
    params.fetch(:search, {}).permit(:artist_name, :genre_id, :activity_location)
  end
end
