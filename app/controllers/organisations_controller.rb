class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.with_sites.order(:title)
    @site_count = Site.count
  end

  def show
    @organisation = Organisation.find_by_whitehall_slug!(params[:id])
    sites = @organisation.sites.includes(:hosts)
    extra_sites = @organisation.extra_sites.includes(:hosts)
    @sites = (sites + extra_sites).sort_by(&:abbr)
  end
end
