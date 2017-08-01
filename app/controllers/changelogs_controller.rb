class ChangelogsController < ApplicationController
  before_action :set_changelog, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @changelogs = Changelog.all
    respond_with(@changelogs)
  end

  def show
    respond_with(@changelog)
  end

  def new
    @changelog = Changelog.new
    respond_with(@changelog)
  end

  def edit
  end

  def create
    @changelog = Changelog.new(changelog_params)
    @changelog.save
    respond_with(@changelog)
  end

  def update
    @changelog.update(changelog_params)
    respond_with(@changelog)
  end

  def destroy
    @changelog.destroy
    respond_with(@changelog)
  end

  private
    def set_changelog
      @changelog = Changelog.find(params[:id])
    end

    def changelog_params
      params.require(:changelog).permit(:dnsname, :ipaddress, :typeanswer)
    end
end
